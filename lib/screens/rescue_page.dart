import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/providers/rescue_list_provider.dart';
import 'package:dog_app/providers/user_provider.dart';
import 'package:dog_app/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:dog_app/entities/dogs.dart';
import 'package:provider/provider.dart';

import '../entities/user.dart';

class RescuePage extends StatefulWidget {
  const RescuePage({super.key});

  @override
  State<RescuePage> createState() => _RescuePageState();
}

class _RescuePageState extends State<RescuePage> {
  final TextEditingController _locationInputController =
      TextEditingController();
  final TextEditingController _sexInputController = TextEditingController();
  final TextEditingController _breedInputController = TextEditingController();
  final TextEditingController _conditionInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rescue Page"),
        backgroundColor: const Color.fromARGB(49, 32, 54, 65),
        // backgroundColor: hexStringToColor("#677891"),
        actions: [
          Center(
            child: Text(
              "No of Dogs = ${Provider.of<RescueListProvider>(context, listen: true).dogsCount}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Consumer<RescueListProvider>(
        builder: (context, value, child) => RescueList(
          user: user,
          dogs: value.dogs,
        ),
      ),
      floatingActionButton: Visibility(
        visible: user.type == "User",
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Enter the details: "),
                  content: Column(
                    children: <Widget>[
                      reusableTextField("Location", Icons.location_pin, false,
                          _locationInputController),
                      const SizedBox(
                        height: 10,
                      ),
                      reusableTextField("Condition", Icons.local_hospital,
                          false, _conditionInputController),
                      const SizedBox(
                        height: 10,
                      ),
                      reusableTextField(
                          "Sex", Icons.male, false, _sexInputController),
                      const SizedBox(
                        height: 10,
                      ),
                      reusableTextField("Breed", Icons.type_specimen, false,
                          _breedInputController),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text("Submit"),
                      onPressed: () {
                        Provider.of<RescueListProvider>(context, listen: false)
                            .addDog(
                                _locationInputController.text,
                                "assets/images/adopt.webp",
                                _sexInputController.text,
                                _breedInputController.text,
                                _conditionInputController.text,
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user!
                                    .email);
                        Navigator.of(context).pop();
                        _locationInputController.text = "";
                        _sexInputController.text = "";
                        _breedInputController.text = "";
                        _conditionInputController.text = "";
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class RescueList extends StatefulWidget {
  const RescueList({required this.dogs, required this.user, super.key});
  final List<Dog> dogs;
  final User user;
  @override
  State<RescueList> createState() => _RescueListState();
}

class _RescueListState extends State<RescueList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dogs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(widget.dogs[index].image),
          title: Text(widget.dogs[index].location),
          subtitle: Text(widget.dogs[index].condition),
          tileColor: const Color.fromARGB(255, 166, 200, 220),
          trailing: Visibility(
            visible: widget.user.type == "User",
            child: Visibility(
              visible: widget.dogs[index].email == widget.user.email,
              child: SizedBox(
                  width: 50,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 14, 13, 13),
                    ),
                    onPressed: () {
                      // removed customer
                      Provider.of<RescueListProvider>(context, listen: false)
                          .removeDog(widget.dogs[index]);
                    },
                  )),
            ),
          ),
          onTap: () {
            showDetails(context, widget.dogs[index]);
          },
        );
      },
    );
  }

  void showDetails(BuildContext context, Dog dog) async {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final user = await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: dog.email)
        .get();
    final String phoneNumber = user.docs.first.data()["Phone Number"];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return (AlertDialog(
          title: const Text("Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(dog.image),
              Text("Breed:${dog.breed}", style: textStyle),
              Text("Sex:${dog.sex}", style: textStyle),
              Text("Condition:${dog.condition}", style: textStyle),
              Text("PhoneNumber: $phoneNumber", style: textStyle),
            ],
          ),
        ));
      },
    );
  }
}

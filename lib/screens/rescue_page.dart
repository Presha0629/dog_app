import 'package:dog_app/providers/rescue_list_provider.dart';
import 'package:dog_app/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:dog_app/entities/dogs.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rescue Page"),
        actions: [
          Center(
            child: Text(
              "No of Dogs = ${Provider.of<RescueListProvider>(context, listen: false).dogsCount}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Consumer<RescueListProvider>(
        builder: (context, value, child) => RescueList(
          dogs: value.dogs,
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                          Provider.of<RescueListProvider>(context,
                                  listen: false)
                              .addDog(
                                  _locationInputController.text,
                                  "assets/images/adopt.webp",
                                  _sexInputController.text,
                                  _breedInputController.text,
                                  _conditionInputController.text);
                          Navigator.of(context).pop();
                          _locationInputController.text = "";
                          _sexInputController.text = "";
                          _breedInputController.text = "";
                          _conditionInputController.text = "";
                        },
                      ),
                    ]);
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RescueList extends StatefulWidget {
  const RescueList({required this.dogs, super.key});
  final List<Dog> dogs;
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
          tileColor: const Color.fromARGB(255, 246, 173, 173),
          trailing: SizedBox(
            width: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 14, 13, 13),
                  ),
                  onPressed: () {
                    // removed customer
                    Provider.of<RescueListProvider>(context, listen: false)
                        .removeDog(widget.dogs[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

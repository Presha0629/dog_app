import 'package:dog_app/providers/adoption_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dog_app/entities/dogs.dart';
import 'package:dog_app/reusable_widgets/reusable_widget.dart';

class AdoptionPage extends StatefulWidget {
  const AdoptionPage({super.key});

  @override
  State<AdoptionPage> createState() => _AdoptionPageState();
}

class _AdoptionPageState extends State<AdoptionPage> {
  final TextEditingController _sexInputController = TextEditingController();
  final TextEditingController _breedInputController = TextEditingController();
  final TextEditingController _conditionInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption Page"),
        actions: [
          Center(
            child: Text(
              "No of Dogs = ${Provider.of<AdoptionListProvider>(context, listen: true).dogsCount}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Consumer<AdoptionListProvider>(
        builder: (context, value, index) {
          return AdoptList(dogs: value.dogs);
        },
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
                    reusableTextField("Condition", Icons.local_hospital, false,
                        _conditionInputController),
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
                      Provider.of<AdoptionListProvider>(context, listen: false)
                          .addDog(
                              "assets/images/adopt.webp",
                              _sexInputController.text,
                              _breedInputController.text,
                              _conditionInputController.text);
                      Navigator.of(context).pop();
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
    );
  }
}

class AdoptList extends StatefulWidget {
  const AdoptList({
    required this.dogs,
    super.key,
  });
  final List<Dog> dogs;

  @override
  State<AdoptList> createState() => _AdoptListState();
}

class _AdoptListState extends State<AdoptList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.dogs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(widget.dogs[index].image),
            title: Text(widget.dogs[index].breed),
            subtitle: Text(widget.dogs[index].sex),
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
                      Provider.of<AdoptionListProvider>(context, listen: false)
                          .removeDog(widget.dogs[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

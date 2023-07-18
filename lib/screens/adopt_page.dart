import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/entities/user.dart';
import 'package:dog_app/providers/adoption_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dog_app/entities/dogs.dart';
import 'package:dog_app/reusable_widgets/reusable_widget.dart';

import '../providers/user_provider.dart';

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

  File? _image;
  Future getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image == null ? null : File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption Page"),
        backgroundColor: const Color.fromARGB(49, 32, 54, 65),
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
          return AdoptList(user: user, dogs: value.dogs);
        },
      ),
      floatingActionButton: Visibility(
        visible: user.type == "Organization",
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Enter the details: "),
                  content: Column(
                    children: <Widget>[
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              getImage(false);
                            },
                            icon: const Icon(Icons.file_upload),
                          ),
                          IconButton(
                            onPressed: () {
                              getImage(true);
                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                          _image == null
                              ? Container()
                              : Image.file(
                                  _image!,
                                  height: 50,
                                  width: 50,
                                ),
                        ],
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text("Submit"),
                      onPressed: () async {
                        var data = {
                          "Breed": _breedInputController.text,
                          "Condition": _conditionInputController.text,
                          "Sex": _sexInputController.text,
                          "User Email":
                              Provider.of<UserProvider>(context, listen: false)
                                  .user!
                                  .email
                        };
                        await FirebaseFirestore.instance
                            .collection("AdoptionList")
                            .add(data)
                            .whenComplete(() {
                          debugPrint("DEBUG::Stored to AdoptionListDatabase");
                        });
                        Provider.of<AdoptionListProvider>(context,
                                listen: false)
                            .addDog(
                                _image,
                                _sexInputController.text,
                                _breedInputController.text,
                                _conditionInputController.text,
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user!
                                    .email);
                        Navigator.of(context).pop();
                        _sexInputController.text = "";
                        _breedInputController.text = "";
                        _conditionInputController.text = "";
                        _image = null;
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Visibility(
              visible: user.type == "Organization",
              child: const Icon(Icons.add)),
        ),
      ),
    );
  }
}

class AdoptList extends StatefulWidget {
  const AdoptList({
    required this.dogs,
    required this.user,
    super.key,
  });
  final User user;
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
            leading: widget.dogs[index].image,
            title: Text(widget.dogs[index].breed),
            subtitle: Text(widget.dogs[index].sex),
            tileColor: const Color.fromARGB(255, 166, 200, 220),
            trailing: Visibility(
              visible: widget.user.type == "Organization",
              child: Visibility(
                visible: widget.user.email == widget.dogs[index].email,
                child: SizedBox(
                  width: 50,
                  child: IconButton(
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
                ),
              ),
            ),
            onTap: () {
              showDetails(context, widget.dogs[index]);
            },
          );
        });
  }

  void showDetails(BuildContext context, Dog dog) async {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final user = await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: dog.email)
        .get();
    final phoneNumber = user.docs.first.data()["Phone Number"];
    debugPrint("DEBUG:: DATA = ${dog.email}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return (AlertDialog(
          title: const Text("Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dog.image,
              Text("Breed:${dog.breed}", style: textStyle),
              Text("Sex:${dog.sex}", style: textStyle),
              Text("Condition:${dog.condition}", style: textStyle),
              Text(
                "Phone No: $phoneNumber",
                style: textStyle,
              )
            ],
          ),
        ));
      },
    );
  }
}

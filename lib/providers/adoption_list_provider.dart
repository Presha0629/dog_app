import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dog_app/entities/dogs.dart';

class AdoptionListProvider extends ChangeNotifier {
  final List<Dog> _dogs = <Dog>[];
  List<Dog> get dogs => _dogs;
  int get dogsCount => _dogs.length;
  void addDog(File? imageFile, String sex, String breed, String condition,
      String email) {
    Image image = imageFile == null
        ? Image.asset("assets/images/adopt.webp")
        : Image.file(imageFile);
    _dogs.add(Dog("", image, sex, breed, condition, email));
    notifyListeners();
  }

  void removeDog(Dog dog) {
    _dogs.remove(dog);
    notifyListeners();
  }
}

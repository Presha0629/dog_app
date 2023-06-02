import 'package:flutter/material.dart';
import 'package:dog_app/entities/dogs.dart';

class AdoptionListProvider extends ChangeNotifier {
  final List<Dog> _dogs = <Dog>[];
  List<Dog> get dogs => _dogs;
  int get dogsCount => _dogs.length;
  void addDog(String image, String sex, String breed, String condition) {
    _dogs.add(Dog("", image, sex, breed, condition));
    notifyListeners();
  }

  void removeDog(Dog dog) {
    _dogs.remove(dog);
    notifyListeners();
  }
}

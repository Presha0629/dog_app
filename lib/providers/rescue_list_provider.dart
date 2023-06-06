import 'package:dog_app/entities/dogs.dart';
import 'package:flutter/material.dart';

class RescueListProvider extends ChangeNotifier {
  final List<Dog> _dogs = <Dog>[];

  List<Dog> get dogs => _dogs;
  int get dogsCount => _dogs.length;

  void addDog(String location, String image, String sex, String breed,
      String condition, String email) {
    _dogs.add(Dog(location, image, sex, breed, condition, email));
    notifyListeners();
  }

  void removeDog(Dog dog) {
    _dogs.remove(dog);
    notifyListeners();
  }
}

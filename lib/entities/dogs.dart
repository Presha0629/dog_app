class Dog {
  final String _Location;
  final String _Image;
  final String _Sex;
  final String _Breed;
  final String _Condition;
  final String _email;

  Dog(this._Location, this._Image, this._Sex, this._Breed, this._Condition,
      this._email);

  String get location => _Location;
  String get image => _Image;
  String get sex => _Sex;
  String get breed => _Breed;
  String get condition => _Condition;
  String get email => _email;
}

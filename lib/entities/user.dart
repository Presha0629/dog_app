class User {
  final String _userName;
  final String _email;
  final String _type;
  final String _phoneNumber;
  final String _location;

  User(this._userName, this._email, this._type, this._phoneNumber,
      this._location);
  String get type => _type;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get userName => _userName;
  String get location => _location;
  bool AddToRescueList() {
    return true;
  }

  bool adopt() {
    return true;
  }

  bool donate() {
    return true;
  }
}

class User {
  final String _userName;
  final String _email;
  final String _type;

  User(this._userName, this._email, this._type);

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

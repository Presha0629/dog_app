class BaseUser {
  final String _email;
  final String _password;

  BaseUser(this._email, this._password);

  bool login() {
    return true;
  }

  bool logout() {
    return true;
  }

  bool delete() {
    return true;
  }
}

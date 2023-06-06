class OrganizationUser {
  final String _OrgName;
  final String _PhoneNo;
  final String _Location;
  final String _phoneNumber;

  OrganizationUser(
      this._OrgName, this._PhoneNo, this._Location, this._phoneNumber);

  bool AddToAdoptList() {
    return true;
  }

  // String get PhoneNo => _PhoneNo;

  // String get Location => _Location;

  bool Rescue() {
    return true;
  }
}

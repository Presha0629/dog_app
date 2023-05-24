class OrganizationUser {
  final String _OrgName;
  final String _PhoneNo;
  final String _Location;

  OrganizationUser(this._OrgName, this._PhoneNo, this._Location);

  bool AddToAdoptList() {
    return true;
  }

  // String get PhoneNo => _PhoneNo;

  // String get Location => _Location;

  bool Rescue() {
    return true;
  }
}

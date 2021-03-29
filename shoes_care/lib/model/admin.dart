class Admin {
  Admin(
      {this.adminId,
      this.adminName,
      this.adminEmail,
      this.adminPassword,
      this.adminPhone,
      this.adminAddress});
  String adminId;
  String adminName;
  String adminEmail;
  String adminPassword;
  String adminPhone;
  String adminAddress;

  String get getAdminId {
    return adminId;
  }

  String get getAdminName {
    return adminName;
  }

  String get getAdminEmail {
    return adminEmail;
  }

  String get getAdminPassword {
    return adminPassword;
  }

  String get getAdminPhone {
    return adminPhone;
  }

  String get getAdminAddress {
    return adminAddress;
  }

  set setAdminId(String newAdminId) {
    adminId = newAdminId;
  }

  set setAdminName(String newAdminName) {
    adminName = newAdminName;
  }

  set setAdminEmail(String newAdminEmail) {
    adminEmail = newAdminEmail;
  }

  set setAdminPassword(String newAdminPassword) {
    adminPassword = newAdminPassword;
  }

  set setAdminPhone(String newAdminPhone) {
    adminPhone = newAdminPhone;
  }

  set setAdminAddress(String newAdminAddress) {
    adminAddress = newAdminAddress;
  }
}

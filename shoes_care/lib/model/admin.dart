import 'package:shoes_care/model/user.dart';

class Admin extends User {
  Admin(
      {this.adminId,
      this.adminName,
      email,
      password,
      this.adminPhone,
      this.adminAddress})
      : super(email: email, password: password);
  String adminId;
  String adminName;
  // String adminEmail;
  // String adminPassword;
  String adminPhone;
  String adminAddress;

  String get getAdminId {
    return adminId;
  }

  String get getAdminName {
    return adminName;
  }

  // String get getAdminEmail {
  //   return super.email;
  // }

  // String get getAdminPassword {
  //   return super.password;
  // }

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

  // set setAdminEmail(String newAdminEmail) {
  //   super.setEmail
  // }

  // set setAdminPassword(String newAdminPassword) {
  //   adminPassword = newAdminPassword;
  // }

  set setAdminPhone(String newAdminPhone) {
    adminPhone = newAdminPhone;
  }

  set setAdminAddress(String newAdminAddress) {
    adminAddress = newAdminAddress;
  }
}

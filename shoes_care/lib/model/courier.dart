import 'package:shoes_care/model/user.dart';

class Courier extends User {
  Courier(
      {this.courierId,
      this.courierName,
      email,
      password,
      this.courierPhone,
      this.courierAddress,
      this.courierNOPOL})
      : super(email: email, password: password);
  String courierId;
  String courierName;
  // String courierEmail;
  // String courierPassword;
  String courierPhone;
  String courierAddress;
  String courierNOPOL;

  String get getCourierId {
    return courierId;
  }

  String get getCourierName {
    return courierName;
  }

  // String get getCourierEmail {
  //   return courierEmail;
  // }

  // String get getCourierPassword {
  //   return courierPassword;
  // }

  String get getCourierPhone {
    return courierPhone;
  }

  String get getCourierAddress {
    return courierAddress;
  }

  String get getCourierNOPOL {
    return courierNOPOL;
  }

  set setCourierId(String newCourierId) {
    courierId = newCourierId;
  }

  set setCourierName(String newCourierName) {
    courierName = newCourierName;
  }

  // set setCourierEmail(String newCourierEmail) {
  //   courierEmail = newCourierEmail;
  // }

  // set setCourierPassword(String newCourierPassword) {
  //   courierPassword = newCourierPassword;
  // }

  set setCourierPhone(String newCourierPhone) {
    courierPhone = newCourierPhone;
  }

  set setCourierAddress(String newCourierAddress) {
    courierAddress = newCourierAddress;
  }

  set setCourierNOPOL(String newCourierNOPOL) {
    courierNOPOL = newCourierNOPOL;
  }
}

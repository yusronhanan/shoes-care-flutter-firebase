import 'package:shoes_care/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<bool> get insert async {
    //insert to firebase (create)
    String createUserWithEmailAndPassword = await super.createUser();
    if (createUserWithEmailAndPassword != null &&
        createUserWithEmailAndPassword == "User Created") {
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('courier');

      collection.add({
        "courier_NOPOL": courierNOPOL,
        "courier_address": courierAddress,
        "courier_email": super.email,
        "courier_name": courierName,
        "courier_phone": courierPhone,
      }).then((value) {
        print("$value Added");
        return true;
      }).catchError((error) {
        print("Failed to add user: $error");
        return false;
      });
    } else {
      print("Failed to add user: $createUserWithEmailAndPassword");
      return false;
    }
    return false;
  }
}

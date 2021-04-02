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

//firebase management
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
        courierId = value.id;
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

  set syncData(String courierId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('courier');
    collection.doc(courierId).get().then((doc) {
      courierName = doc['courier_name'];
      super.setEmail(doc['courier_email']);
      // String courierPassword;
      courierPhone = doc['courier_phone'];
      courierAddress = doc['courier_address'];
      courierNOPOL = doc['courier_NOPOL'];
    });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('courier');
    collection.doc(courierId).update({
      "courier_name": courierName,
      "courier_email": super.getEmail,
      "courier_phone": courierPhone,
      "courier_address": courierAddress,
      "courier_NOPOL": courierNOPOL,
      //TO DO: need to update email and password in firebase authentication too
    }).then((value) {
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update courier: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('courier');
    collection.doc(courierId).delete().then((value) {
      //TO DO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete courier: $error");
      return false;
    });
    return false;
  }

  // creating a Trip object from a firebase snapshot
  Courier.fromSnapshot(DocumentSnapshot snapshot) {
    courierId = snapshot.id;
    courierNOPOL = snapshot["courier_NOPOL"];
    courierAddress = snapshot["courier_address"];
    super.setEmail(snapshot["courier_email"]);
    courierName = snapshot["courier_name"];
    courierPhone = snapshot["courier_phone"];
  }
  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        "courier_name": courierName,
        "courier_email": super.getEmail,
        "courier_phone": courierPhone,
        "courier_address": courierAddress,
        "courier_NOPOL": courierNOPOL,
      };
}

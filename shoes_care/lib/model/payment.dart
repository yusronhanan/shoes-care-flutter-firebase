import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Payment {
  Payment({this.paymentId, this.paymentName});
  String paymentId;
  String paymentName;

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String get getPaymentId {
    return paymentId;
  }

  String get getPaymentName {
    return paymentName;
  }

  set setPaymentId(String newPaymentId) {
    paymentId = newPaymentId;
  }

  set setPaymentName(String newPaymentName) {
    paymentName = newPaymentName;
  }
  String getRandomString(int length)  {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)

    // if success create user with email and password: since email and password w/ collection data is in different configuration
    CollectionReference collection =
        FirebaseFirestore.instance.collection('payment');
    String customId = getRandomString(6);

    collection.doc(customId).set({
      "payment_name": paymentName,
    }).then((value) {
      paymentId = customId;
      return true;
    }).catchError((error) {
      print("Failed to add payment: $error");
      return false;
    });

    return false;
  }

  set syncData(String paymentId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('payment');
    collection.doc(paymentId).get().then((doc) {
      paymentName = doc['payment_name'];

      // String courierPassword;
    });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('payment');
    collection.doc(paymentId).update({
      "payment_name": paymentName,
      //TODO: need to update email and password in firebase authentication too
    }).then((value) {
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update payment: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('payment');
    collection.doc(paymentId).delete().then((value) {
      //TODO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete payment: $error");
      return false;
    });
    return false;
  }

  // creating a Trip object from a firebase snapshot
  Payment.fromSnapshot(DocumentSnapshot snapshot) {
    paymentId = snapshot.id;
    paymentName = snapshot["payment_name"];
  }
  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    "payment_name": paymentName,
  };
}

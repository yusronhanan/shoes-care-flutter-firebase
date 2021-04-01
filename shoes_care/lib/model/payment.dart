import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  Payment({this.paymentId, this.paymentName});
  String paymentId;
  String paymentName;

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
//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)
    
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('payment');

      collection.add({
        "payment_name": paymentName,
      }).then((value) {
        paymentId = value.id;
        print("$value Added");
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
      //TO DO: need to update email and password in firebase authentication too
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
      //TO DO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete payment: $error");
      return false;
    });
    return false;
  }
}
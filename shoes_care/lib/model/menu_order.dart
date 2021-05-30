import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class MenuOrder {
  MenuOrder(
      {this.menuOrderId,
      this.menuOrderType,
      this.menuOrderPrice,
      this.menuOrderDuration});
  String menuOrderId;
  String menuOrderType;
  int menuOrderPrice;
  String menuOrderDuration;

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String get getMenuOrderId {
    return menuOrderId;
  }

  String get getMenuOrderType {
    return menuOrderType;
  }

  int get getMenuOrderPrice {
    return menuOrderPrice;
  }

  String get getMenuOrderDuration {
    return menuOrderDuration;
  }

  set setMenuOrderId(String newMenuOrderId) {
    menuOrderId = newMenuOrderId;
  }

  set setMenuOrderType(String newMenuOrderType) {
    menuOrderType = newMenuOrderType;
  }

  set setMenuOrderPrice(int newMenuOrderPrice) {
    menuOrderPrice = newMenuOrderPrice;
  }

  set setMenuOrderDuration(String newMenuOrderDuration) {
    menuOrderDuration = newMenuOrderDuration;
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
        FirebaseFirestore.instance.collection('menuorder');
    String customId = getRandomString(6);

    collection.doc(customId).set({
      "menuorder_duration": menuOrderDuration,
      "menuorder_price": menuOrderPrice,
      "menuorder_type": menuOrderType,
    }).then((value) {
      menuOrderId = customId;
      return true;
    }).catchError((error) {
      print("Failed to add menuorder: $error");
      return false;
    });

    return false;
  }

  set syncData(String menuOrderId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('menuorder');
    collection.doc(menuOrderId).get().then((doc) {
      menuOrderDuration = doc['menuorder_duration'];
      menuOrderPrice = doc['menuorder_price'];
      menuOrderType = doc['menuorder_type'];

      // String courierPassword;
    });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('menuorder');
    collection.doc(menuOrderId).update({
      "menuorder_duration": menuOrderDuration,
      "menuorder_price": menuOrderPrice,
      "menuorder_type": menuOrderType,
    }).then((value) {
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update menuorder: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('menuorder');
    collection.doc(menuOrderId).delete().then((value) {
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete menuorder: $error");
      return false;
    });
    return false;
  }

  // creating a Trip object from a firebase snapshot
  MenuOrder.fromSnapshot(DocumentSnapshot snapshot) {
    menuOrderId = snapshot.id;
    menuOrderDuration = snapshot["menuorder_duration"];
    menuOrderPrice = snapshot["menuorder_price"];
    menuOrderType = snapshot["menuorder_type"];

  }
  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    "menuorder_duration": menuOrderDuration,
    "menuorder_price": menuOrderPrice,
    "menuorder_type": menuOrderType,
  };
}

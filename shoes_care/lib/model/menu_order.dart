import 'package:cloud_firestore/cloud_firestore.dart';
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

//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)
    
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('menuorder');

      collection.add({
        "menuorder_duration": menuOrderDuration,
        "menuorder_price": menuOrderPrice,
        "menuorder_type": menuOrderType,
      }).then((value) {
        menuOrderId = value.id;
        print("$value Added");
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
      //TO DO: need to update email and password in firebase authentication too
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
      //TO DO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete menuorder: $error");
      return false;
    });
    return false;
  }
}
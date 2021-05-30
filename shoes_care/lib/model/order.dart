import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Order {
  Order(
      {this.orderId,
      this.adminId,
      this.customerId,
      this.courierId,
      this.paymentId,
      this.menuOrderType,
      this.orderAddress,
      this.orderPickupTime,
      this.orderDateTime,
      this.orderStatus});
  String orderId;
  String adminId;
  String customerId;
  String courierId;
  String paymentId;
  String menuOrderType;
  String orderAddress;
  String orderPickupTime;
  DateTime orderDateTime;
  String orderStatus;
  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String get getOrderId {
    return orderId;
  }

  String get getAdminId {
    return adminId;
  }

  String get getCustomerId {
    return customerId;
  }

  String get getCourierId {
    return courierId;
  }

  String get getPaymentId {
    return paymentId;
  }

  String get getMenuOrderType {
    return menuOrderType;
  }

  String get getOrderAddress {
    return orderAddress;
  }

  String get getOrderPickupTime {
    return orderPickupTime;
  }

  DateTime get getOrderDateTime {
    return orderDateTime;
  }

  String get getOrderStatus {
    return orderStatus;
  }

  set setOrderId(String newrOderId) {
    orderId = newrOderId;
  }

  set setAdminId(String newAdminId) {
    adminId = newAdminId;
  }

  set setCustomerId(String newCustomerId) {
    customerId = newCustomerId;
  }

  set setCourierId(String newCourierId) {
    courierId = newCourierId;
  }

  set setPaymentId(String newPaymentId) {
    paymentId = newPaymentId;
  }

  set setMenuOrderType(String newMenuOrderType) {
    menuOrderType = newMenuOrderType;
  }

  set setOrderAddress(String newOrderAddress) {
    orderAddress = newOrderAddress;
  }

  set setOrderPickupTime(String newOrderPickupTime) {
    orderPickupTime = newOrderPickupTime;
  }

  set setOrderDateTime(DateTime newOrderDateTime) {
    orderDateTime = newOrderDateTime;
  }

  set setOrderStatus(String newOrderStatus) {
    orderStatus = newOrderStatus;
  }

  String getRandomString(int length)  {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)

    CollectionReference collection =
        FirebaseFirestore.instance.collection('order');
    String customId = getRandomString(6);
    collection.doc(customId).set({
      "admin_id": adminId,
      "courier_id": courierId,
      "customer_id": customerId,
      "menuorder_type": menuOrderType,
      "order_address": orderAddress,
      "order_datetime": Timestamp.fromDate(orderDateTime),
      "order_pickuptime": orderPickupTime,
      "order_status": orderStatus,
      "payment_id": paymentId,
    }).then((value) {
      orderId = customId;
      return true;
    }).catchError((error) {
      print("Failed to add order: $error");
      return false;
    });

    return false;
  }



  set syncData(String orderId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('order');
    collection.doc(orderId).get().then((doc) {
      adminId = doc['admin_id'];
      courierId = doc['courier_id'];
      customerId = doc['customer_id'];
      menuOrderType = doc['menu_ordertype'];
      orderAddress = doc['order_address'];
      orderDateTime = doc['order_datetime'];
      orderPickupTime = doc['order_pickuptime'];
      orderStatus = doc['order_status'];
      paymentId = doc['payment_id'];
      // String courierPassword;
    });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('order');
    collection.doc(orderId).update({
      "admin_id": adminId,
      "courier_id": courierId,
      "customer_id": customerId,
      "menuorder_type": menuOrderType,
      "order_address": orderAddress,
      "order_datetime": Timestamp.fromDate(orderDateTime),
      "order_pickuptime": orderPickupTime,
      "order_status": orderStatus,
      "payment_id": paymentId,
      //TODO: need to update email and password in firebase authentication too
    }).then((value) {
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update order: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('order');
    collection.doc(orderId).delete().then((value) {
      //TODO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete order: $error");
      return false;
    });
    return false;
  }

  // creating a Trip object from a firebase snapshot
  Order.fromSnapshot(DocumentSnapshot snapshot) {
    orderId = snapshot.id;
    adminId = snapshot["admin_id"];
    courierId = snapshot["courier_id"];
    customerId = snapshot["customer_id"];
    menuOrderType = snapshot["menuorder_type"];
    orderAddress = snapshot["order_address"];
    orderDateTime = snapshot["order_datetime"].toDate();
    orderPickupTime = snapshot["order_pickuptime"];
    orderStatus = snapshot["order_status"];
    paymentId = snapshot["payment_id"];
  }
  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        "admin_id": adminId,
        "courier_id": courierId,
        "customer_id": customerId,
        "menuorder_type": menuOrderType,
        "order_address": orderAddress,
        "order_datetime": orderDateTime,
        "order_pickuptime": orderPickupTime,
        "order_status": orderStatus,
        "payment_id": paymentId,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';
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
  DateTime orderPickupTime;
  DateTime orderDateTime;
  String orderStatus;

  String get getrderId {
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

  DateTime get getOrderPickupTime {
    return orderPickupTime;
  }

  DateTime get getOrderDateTime {
    return orderDateTime;
  }

  String get getOrderStatus {
    return orderStatus;
  }

  set setrderId(String newrderId) {
    orderId = newrderId;
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

  set setOrderPickupTime(DateTime newOrderPickupTime) {
    orderPickupTime = newOrderPickupTime;
  }

  set setOrderDateTime(DateTime newOrderDateTime) {
    orderDateTime = newOrderDateTime;
  }

  set setOrderStatus(String newOrderStatus) {
    orderStatus = newOrderStatus;
  }

//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)
    
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('order');

      collection.add({
        "admin_id": adminId,
        "courier_id": courierId,
        "customer_id": customerId,
        "menuorder_type": menuOrderType,
        "order_address": orderAddress,
        "order_datetime": orderDateTime,
        "order_pickuptime": orderPickupTime,
        "order_status": orderStatus,
        "payment_id": paymentId,
      }).then((value) {
        orderId = value.id;
        print("$value Added");
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
      "order_datetime": orderDateTime,
      "order_pickuptime": orderPickupTime,
      "order_status": orderStatus,
      "payment_id": paymentId,
      //TO DO: need to update email and password in firebase authentication too
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
      //TO DO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete order: $error");
      return false;
    });
    return false;
  }
}
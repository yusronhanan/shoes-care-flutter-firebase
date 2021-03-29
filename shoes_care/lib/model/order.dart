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
}

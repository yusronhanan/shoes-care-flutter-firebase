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
}

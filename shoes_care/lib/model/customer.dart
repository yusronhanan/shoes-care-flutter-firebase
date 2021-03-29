import 'package:shoes_care/model/user.dart';

class Customer extends User {
  Customer(
      {this.customerId,
      this.customerName,
      email,
      password,
      this.customerPhone,
      this.customerAddress})
      : super(email: email, password: password);
  String customerId;
  String customerName;
  // String customerEmail;
  // String customerPassword;
  String customerPhone;
  String customerAddress;

  String get getCustomerId {
    return customerId;
  }

  String get getCustomerName {
    return customerName;
  }

  // String get getCustomerEmail {
  //   return customerEmail;
  // }

  // String get getCustomerPassword {
  //   return customerPassword;
  // }

  String get getCustomerPhone {
    return customerPhone;
  }

  String get getCustomerAddress {
    return customerAddress;
  }

  set setCustomerId(String newCustomerId) {
    customerId = newCustomerId;
  }

  set setCustomerName(String newCustomerName) {
    customerName = newCustomerName;
  }

  // set setCustomerEmail(String newCustomerEmail) {
  //   super.setEmail(newCustomerEmail);
  // }

  // set setCustomerPassword(String newCustomerPassword) {
  //   customerPassword = newCustomerPassword;
  // }

  set setCustomerPhone(String newCustomerPhone) {
    customerPhone = newCustomerPhone;
  }

  set setCustomerAddress(String newCustomerAddress) {
    customerAddress = newCustomerAddress;
  }
}

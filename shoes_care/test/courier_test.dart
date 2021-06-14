import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_care/model/courier.dart';
void main() {
  test('Should able get the courier data by email', () async {
    // Build our app and trigger a frame.
    await Firebase.initializeApp();
    Courier courierTest =  Courier(
        courierId: "",
        courierName: "",
        email: "",
        password: "",
        courierPhone: "",
        courierAddress: "",
        courierNOPOL: "");
    await courierTest.syncDataByEmail("courier3@gmail.com");

    // Verify that our counter starts at 0.
    expect(courierTest.getCourierName, "Courier 3");
    expect(courierTest.getCourierPhone, "08000033");
    expect(courierTest.getCourierAddress, "courier street 03");
    expect(courierTest.getCourierNOPOL, "D KK 003");
  });
}

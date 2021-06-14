import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_care/model/menu_order.dart';
void main() {
  test('Should able get the menu order data by type', () async {
    // Build our app and trigger a frame.
    await Firebase.initializeApp();
    MenuOrder moTest =  MenuOrder(
    menuOrderDuration: 0,
    menuOrderPrice: 0,
    menuOrderType: "",
    menuOrderId: "");

    moTest.syncData("Unyellowing");

    // Verify that our counter starts at 0.
    expect(moTest.getMenuOrderDuration, 2);
    expect(moTest.getMenuOrderPrice, 25000);
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/courierUI/courier_navigation_view.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/model/customer.dart';



Future<String> _fetchUserData(customerEmail) async {
  String customerName = customerEmail;
  // here you write the codes to input the data into firestore
  Customer customerData = Customer(
      customerId: "",
      customerName: "",
      email: customerEmail,
      password: "",
      customerPhone: "",
      customerAddress: "");
  await customerData.syncDataByEmail(customerEmail);
  customerName = customerData.getCustomerName;
  return customerName;
}

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);



    _buildTiles(context, Order root, customerName) {

      if (customerName == ""){
        customerName = root.getCustomerId;
      }
    String textOrder = '#'+root.orderId + ' \n'
        +root.getOrderStatus +' on '+  DateFormat('dd/MM/yyyy')
        .format(root.orderDateTime).toString() +' around '+ root.getOrderPickupTime +' \n'
        +customerName +' - '+root.getMenuOrderType + '\n'
        +root.getOrderAddress
        ;
      return ListTile(
        title: Text(textOrder),
        subtitle: Column(
          children: <Widget>[
            Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Done"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext bc) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                        child:Text("Are you sure you want to change the status into Progress?",
                                        style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.center,
                                        )),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: root.getCourierId,
                                                  customerId: root.getCustomerId,
                                                  menuOrderType: root.getMenuOrderType,
                                                  orderAddress: root.getOrderAddress,
                                                  orderDateTime: root.getOrderDateTime,
                                                  orderPickupTime: root.getOrderPickupTime,
                                                  orderStatus: 'Progress',
                                                  paymentId: "");
                                              currentOrder.update;
                                              Navigator.of(context, rootNavigator: true).pop();
                                              Navigator.push(
                                                  bc,
                                                  MaterialPageRoute(
                                                      builder: (context) => CourierHome(index: 1)));
                                              // Navigator.of(context).pushNamedAndRemoveUntil('/courierPickup', (Route<dynamic> route) => false);
                                              // Navigator.pushNamed(context, '/courierPickup');

                                              var snackBar =
                                              SnackBar(content: Text('Yay! It Success.'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context, rootNavigator: true).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // return  _buildTiles(entry);
    return FutureBuilder(
      future: _fetchUserData(entry.getCustomerId),
      builder: (BuildContext bc, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          print("customerName:" + snapshot.data);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _buildTiles(context, entry, "");
            break;
            case ConnectionState.done:
              return _buildTiles(context, entry, snapshot.data);
              break;
            default:
              return _buildTiles(context, entry, snapshot.data);
          }
        } else{
          return _buildTiles(context, entry, "");
        }

      },
    );
  }
}


Widget buildPickupOrderCard(BuildContext context, DocumentSnapshot document) {
  final Order order = Order.fromSnapshot(document);

  return EntryItem(order);
}

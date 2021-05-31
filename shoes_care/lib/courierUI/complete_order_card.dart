import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/model/customer.dart';



Future<List> _fetchUserData(customerEmail) async {
  String customerName = customerEmail;
  String customerPhone = "";

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
  customerPhone = customerData.getCustomerPhone;
  return [customerName, customerPhone];
}

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);



    _buildTiles(context, Order root, customerData) {
      TextEditingController paymentIdController = TextEditingController();
      paymentIdController.text = 'Cash';
    if(customerData[0] == ""){
      customerData[0] = root.getCustomerId;
    }
    String textOrder = '#'+root.orderId + ' \n'
        +  DateFormat('dd/MM/yyyy')
            .format(root.getOrderDateTime).toString() +' \n'
        +customerData[0] +' - ' + '\n'
        +root.getMenuOrderType + '\n'
        +'Paid by '+ root.paymentId + '\n'
        ;
    // if(root.orderStatus != 'Complete'){
    //   textOrder +=' - '+root.orderStatus;
    // }
    // if (root.orderId.isEmpty) {
      return ListTile(
        title: Text(textOrder),


      );
  }

  @override
  Widget build(BuildContext context) {
    // return  _buildTiles(entry);
    return FutureBuilder(
      future: _fetchUserData(entry.getCustomerId),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          print("customerData:" + snapshot.data.toString());
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _buildTiles(context, entry, ["",""]);
            break;
            case ConnectionState.done:
              return _buildTiles(context, entry, snapshot.data);
              break;
            default:
              return _buildTiles(context, entry, snapshot.data);
          }
        } else{
          return _buildTiles(context, entry, ["",""]);
        }

      },
    );
  }
}


Widget buildCompleteOrderCard(BuildContext context, DocumentSnapshot document) {
  final Order order = Order.fromSnapshot(document);

  return EntryItem(order);
}

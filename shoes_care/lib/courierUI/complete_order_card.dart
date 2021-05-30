import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      TextEditingController paymentIdController = TextEditingController();
      paymentIdController.text = 'Cash';
      if (customerName == ""){
        customerName = root.getCustomerId;
      }

    String textOrder = '#'+root.orderId + ' \n'
        +root.getOrderStatus +' and paid by '+ root.paymentId + '\n'+  DateFormat('dd/MM/yyyy')
        .format(root.getOrderDateTime).toString() +' \n'
        +customerName +' - '+root.getMenuOrderType + '\n'
        +root.getOrderAddress
        ;
    // if(root.orderStatus != 'Complete'){
    //   textOrder +=' - '+root.orderStatus;
    // }
    // if (root.orderId.isEmpty) {
      return ListTile(
        title: Text(textOrder),


      );
    // }
    // return ExpansionTile(
    //   key: PageStorageKey<Entry>(root),
    //   title: Text(root.title),
    //   children: root.children.map<Widget>(_buildTiles).toList(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // return  _buildTiles(entry);
    return FutureBuilder(
      future: _fetchUserData(entry.getCustomerId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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


Widget buildCompleteOrderCard(BuildContext context, DocumentSnapshot document) {
  final Order order = Order.fromSnapshot(document);

  return EntryItem(order);
}

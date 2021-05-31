import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/model/customer.dart';


final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

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
  final MenuOrder menuOrder;

  const EntryItem(this.entry, this.menuOrder);




  _buildTiles(context, Order root, customerData) {
      TextEditingController paymentIdController = TextEditingController();
      paymentIdController.text = 'Cash';
    if(customerData[0] == ""){
      customerData[0] = root.getCustomerId;
    }
    String textOrder = '#'+root.orderId + ' \n'
        +  'Order date: '+DateFormat('dd/MM/yyyy')
            .format(root.getOrderDateTime).toString() +' \n'
        +customerData[0] + '\n';

      if(menuOrder != null){
        textOrder+= menuOrder.getMenuOrderType + ' - '
            + formatCurrency.format(menuOrder.getMenuOrderPrice) + ' - ' +menuOrder.getMenuOrderDuration.toString()+ ' Days\n';
      }

        textOrder+='Paid by '+ root.paymentId + '\n'
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


Widget buildCompleteOrderCard(BuildContext context, DocumentSnapshot document, List menuOrderList) {
  final Order order = Order.fromSnapshot(document);
  MenuOrder menuOrder = MenuOrder.fromSnapshot(menuOrderList[0]); //default = 0 if null
  for (var mo in menuOrderList) {
    var m = MenuOrder.fromSnapshot(mo);
    if(m.getMenuOrderType == order.getMenuOrderType){
      menuOrder = m;
    }
  }
  return EntryItem(order, menuOrder);
}

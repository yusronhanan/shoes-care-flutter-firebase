import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/order.dart';



class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Order root) {

    String textOrder = '#'+root.orderId +' \n '+root.getMenuOrderType + ' - '+  DateFormat('dd/MM/yyyy')
        .format(root.orderDateTime)
        .toString();
    if(root.orderStatus != 'Complete'){
      textOrder +=' - '+root.orderStatus;
    }
      return ListTile(
        title: Text(textOrder),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(entry);
  }
}


Widget buildOrderCard(BuildContext context, DocumentSnapshot document) {
  final Order order = Order.fromSnapshot(document);
  return EntryItem(order);
}

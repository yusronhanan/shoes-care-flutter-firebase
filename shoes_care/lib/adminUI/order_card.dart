import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/order.dart';


class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Order root) {
      return ExpansionTile(
        title: Text('#'+root.orderId +' - '+root.getMenuOrderType),
          children: <Widget>[
              ListTile(
                title: Text(root.orderStatus + ' - '+  DateFormat('dd/MM/yyyy')
                            .format(root.orderDateTime)
                            .toString()),
              )
          ],

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

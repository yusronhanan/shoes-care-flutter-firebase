import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/adminUI/detail_order.dart';

Widget buildOrderCard(BuildContext context, DocumentSnapshot document) {
  final order = Order.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(order.getOrderId),
                subtitle: Text(
                  order.getAdminId +
                      '\n' +
                      order.getCourierId +
                      '\n' +
                      order.getCustomerId +
                      '\n' +
                      order.getMenuOrderType +
                      '\n' +
                      order.getOrderAddress +
                      '\n' +
                      DateFormat('dd/MM/yyyy')
                          .format(order.getOrderDateTime)
                          .toString() +
                      '\n' +
                      order.getOrderPickupTime +
                      '\n' +
                      order.getOrderStatus +
                      '\n' +
                      order.getPaymentId,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: AppTheme.maroon,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailOrderView(order: order)),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

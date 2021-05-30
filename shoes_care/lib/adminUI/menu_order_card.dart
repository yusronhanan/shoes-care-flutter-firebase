import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/adminUI/detail_menu_order.dart';

Widget buildMenuOrderCard(BuildContext context, DocumentSnapshot document) {
  final menuOrder = MenuOrder.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(menuOrder.getMenuOrderType),
                subtitle: Text(
                  menuOrder.getMenuOrderPrice.toString() +
                      '\n' +
                      menuOrder.getMenuOrderDuration,
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
                                DetailMenuOrderView(menuOrder: menuOrder)),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:shoes_care/model/customer.dart';
import 'package:shoes_care/adminUI/detail_customer.dart';

Widget buildCustomerCard(BuildContext context, DocumentSnapshot document) {
  // TODO: FIX JOIN AND DISPLAY CARD DESIGN
  final customer = Customer.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(customer.getCustomerName
                    +'\n'+ customer.getEmail
                    +'\n' + customer.getCustomerPhone),
                subtitle: Text(
                  customer.getCustomerAddress,
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
                                DetailCustomerView(customer: customer)),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailCustomerView(customer: customer)),
        //   );
        // },
      ),
    ),
  );
}

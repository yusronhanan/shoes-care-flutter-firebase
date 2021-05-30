import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/payment.dart';
import 'package:shoes_care/adminUI/detail_payment.dart';

Widget buildPaymentCard(BuildContext context, DocumentSnapshot document) {
  final payment = Payment.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(payment.getPaymentName),
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
                                DetailPaymentView(payment: payment)),
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

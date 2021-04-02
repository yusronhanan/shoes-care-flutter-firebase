import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:shoes_care/model/courier.dart';
import 'package:shoes_care/adminUI/detail_courier.dart';

Widget buildCourierCard(BuildContext context, DocumentSnapshot document) {
  final courier = Courier.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(courier.getCourierName),
                subtitle: Text(
                  courier.getEmail +
                      '\n' +
                      courier.getCourierPhone +
                      '\n' +
                      courier.getCourierAddress +
                      '\n' +
                      courier.getCourierNOPOL,
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
                                DetailCourierView(courier: courier)),
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
        //         builder: (context) => DetailCourierView(courier: courier)),
        //   );
        // },
      ),
    ),
  );
}

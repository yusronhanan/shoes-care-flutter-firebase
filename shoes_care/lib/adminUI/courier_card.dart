import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    courier.getCourierName,
                    // style: GoogleFonts.seymourOne(fontSize: 20.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                    courier.getEmail,
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      courier.getCourierPhone,
                      style: new TextStyle(fontSize: 35.0),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => DetailCourierView(courier: courier)),
          // );
        },
      ),
    ),
  );
}

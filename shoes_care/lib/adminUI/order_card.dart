import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/adminUI/detail_order.dart';


// class Entry {
//   final String title;
//   final List<Entry> children;
//   Entry(this.title, [this.children = const <Entry>[]]);
// }

//isi list
// final List data = <Entry>[
//   Entry('In Process', <Entry>[
//     Entry('#202004182 - Yellowing 3 Days', <Entry>[Entry('Testt')]),
//     Entry('#202004183 - Regular 1 Days', <Entry>[Entry('Testt')]),
//     Entry('#202004184 - Regular 2 Days', <Entry>[Entry('Testt')])
//   ]),
//   Entry('Completed', <Entry>[
//     Entry('#202003171 - Repair 5 Days', <Entry>[Entry('Testt')]),
//     Entry('#202004162 - Deep Clean 3 Days', <Entry>[Entry('Testt')]),
//     Entry('#202004163 - Deep Clean 3 Days', <Entry>[Entry('Testt')])
//   ])
// ];

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Order root) {
    // if (root.orderId.isEmpty) {
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
    // }
    // return ExpansionTile(
    //   key: PageStorageKey<Entry>(root),
    //   title: Text(root.title),
    //   children: root.children.map<Widget>(_buildTiles).toList(),
    // );
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




  // return new Container(
  //   child: Card(
  //     child: InkWell(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           children: <Widget>[
  //             ListTile(
  //               title: Text(order.getOrderId),
  //               subtitle: Text(
  //                 order.getAdminId +
  //                     '\n' +
  //                     order.getCourierId +
  //                     '\n' +
  //                     order.getCustomerId +
  //                     '\n' +
  //                     order.getMenuOrderType +
  //                     '\n' +
  //                     order.getOrderAddress +
  //                     '\n' +
  //                     DateFormat('dd/MM/yyyy')
  //                         .format(order.getOrderDateTime)
  //                         .toString() +
  //                     '\n' +
  //                     order.getOrderPickupTime +
  //                     '\n' +
  //                     order.getOrderStatus +
  //                     '\n' +
  //                     order.getPaymentId,
  //                 style: TextStyle(color: Colors.black.withOpacity(0.6)),
  //               ),
  //             ),
  //             ButtonBar(
  //               alignment: MainAxisAlignment.end,
  //               children: [
  //                 // ignore: deprecated_member_use
  //                 FlatButton(
  //                   textColor: AppTheme.maroon,
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) =>
  //                               DetailOrderView(order: order)),
  //                     );
  //                   },
  //                   child: const Text('Edit'),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}

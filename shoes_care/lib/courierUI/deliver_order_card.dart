import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/courierUI/courier_navigation_view.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/model/customer.dart';


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

Future<String> _fetchUserData(customerEmail) async {
  String customerName = customerEmail;
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
  return customerName;
}

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  const EntryItem(this.entry);



    _buildTiles(context, Order root, customerName) {
      TextEditingController paymentIdController = TextEditingController();
      paymentIdController.text = 'Cash';
      if (customerName == ""){
        customerName = root.getCustomerId;
      }

    String textOrder = '#'+root.orderId + ' \n'
        +root.getOrderStatus +' on '+  DateFormat('dd/MM/yyyy')
        .format(root.getOrderDateTime).toString() +' around '+ root.getOrderPickupTime +' \n'
        +customerName +' - '+root.getMenuOrderType + '\n'
        +root.getOrderAddress
        ;
    // if(root.orderStatus != 'Complete'){
    //   textOrder +=' - '+root.orderStatus;
    // }
    // if (root.orderId.isEmpty) {
      return ListTile(
        title: Text(textOrder),
        subtitle: Column(
          children: <Widget>[
            Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Done"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // TextField(
                                        //   decoration: InputDecoration(
                                        //       border: InputBorder.none,
                                        //       hintText: 'What do you want to remember?'),
                                        // ),
                                        Center(
                                        child:Text("Are you sure you want to change the status into Complete?",
                                        style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.center,
                                        )),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                          child: new Row(
                                            children: <Widget>[
                                              new Expanded(
                                                  child: new TextField(
                                                    controller: paymentIdController,
                                                    readOnly: true,
                                                    style: TextStyle(fontSize: 16),
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: "Payment Type",
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      prefixIcon: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.only(start: 12.0),
                                                        child: Icon(Icons
                                                            .payment), // myIcon is a 48px-wide widget.
                                                      ),
                                                      suffixIcon: PopupMenuButton<String>(
                                                        icon: const Icon(Icons.arrow_drop_down),
                                                        onSelected: (String value) {
                                                          paymentIdController.text = value;
                                                        },
                                                        itemBuilder: (BuildContext context) {
                                                          return <String>['Cash', 'Gopay', 'OVO', 'DANA']
                                                              .map<PopupMenuItem<String>>((String value) {
                                                            return new PopupMenuItem(
                                                                child: new Text(value), value: value);
                                                          }).toList();
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: root.getCourierId,
                                                  customerId: root.getCustomerId,
                                                  menuOrderType: root.getMenuOrderType,
                                                  orderAddress: root.getOrderAddress,
                                                  orderDateTime: root.getOrderDateTime,
                                                  orderPickupTime: root.getOrderPickupTime,
                                                  orderStatus: 'Complete',
                                                  paymentId: paymentIdController.text);
                                              currentOrder.update;
                                              paymentIdController.text = 'Cash'; //default to cash
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CourierHome(index: 0)));
                                              var snackBar =
                                              SnackBar(content: Text('Yay! It Success.'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Update",
                                              style: TextStyle(color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        ),


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
    // return  _buildTiles(entry);
    return FutureBuilder(
      future: _fetchUserData(entry.getCustomerId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          print("customerName:" + snapshot.data);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _buildTiles(context, entry, "");
            break;
            case ConnectionState.done:
              return _buildTiles(context, entry, snapshot.data);
              break;
            default:
              return _buildTiles(context, entry, snapshot.data);
          }
        } else{
          return _buildTiles(context, entry, "");
        }

      },
    );
  }
}


Widget buildDeliverOrderCard(BuildContext context, DocumentSnapshot document) {
  final Order order = Order.fromSnapshot(document);

  return EntryItem(order);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/order.dart';

import 'package:shoes_care/adminUI/admin_navigation_view.dart';

// import 'edit_notes_view.dart';
// import 'package:intl/intl.dart';
// import 'package:auto_size_text/auto_size_text.dart';

class DetailOrderView extends StatefulWidget {
  final Order order;

  DetailOrderView({Key key, @required this.order}) : super(key: key);

  @override
  _DetailOrderViewState createState() => _DetailOrderViewState();
}

class _DetailOrderViewState extends State<DetailOrderView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: FIX INPUT
    final String idController = widget.order.getOrderId;

    final TextEditingController adminIdController =
        TextEditingController(text: widget.order.getAdminId);
    final TextEditingController courierIdController =
        TextEditingController(text: widget.order.getCourierId);
    final TextEditingController customerIdController =
        TextEditingController(text: widget.order.getCustomerId);
    final TextEditingController menuOrderTypeController =
        TextEditingController(text: widget.order.getMenuOrderType);
    final TextEditingController orderAddressController =
        TextEditingController(text: widget.order.getOrderAddress);
    final TextEditingController orderStatusController =
        TextEditingController(text: widget.order.getOrderStatus);
    final TextEditingController orderPickupTimeController =
        TextEditingController(text: widget.order.getOrderPickupTime);
// orderDateTime: orderDateTimeController,
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
                size: 30,
              ),
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                _orderEditModalBottomSheet(context);
              },
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          Container(
            height: 800,
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    offset: new Offset(0.0, 2.0),
                    blurRadius: 25.0,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32))),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      // ignore: deprecated_member_use
                      // child: FlatButton(
                      //   onPressed: () {
                      //     // Navigator.pushNamed(context, '/allOrderData');
                      //   },
                      //   child: Text(
                      //     'All Order Data',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(16),
                    //   // ignore: deprecated_member_use
                    //   child: FlatButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Sign Up',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Color(0xff9e2229),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Edit Order',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
                  child: TextField(
                    controller: courierIdController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Courier',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
                  child: TextField(
                    controller: adminIdController,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Admin',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: TextField(
                    controller: customerIdController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Customer',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: TextField(
                    controller: menuOrderTypeController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Menu Order Type',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: TextField(
                    controller: orderAddressController,
                    maxLines: 3,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Order Address',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: TextField(
                    controller: orderPickupTimeController,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Order Pickup Time',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: TextField(
                    controller: orderStatusController,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Order Status',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Color(0xff9e2229), shape: BoxShape.circle),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          print(idController +
                              adminIdController.text +
                              courierIdController.text +
                              customerIdController.text +
                              menuOrderTypeController.text +
                              orderAddressController.text);

                          final newOrder = Order(
                              orderId: idController,
                              adminId: adminIdController.text,
                              courierId: courierIdController.text,
                              customerId: customerIdController.text,
                              menuOrderType: menuOrderTypeController.text,
                              orderAddress: orderAddressController.text,
                              //TODO: TAKE CARE OF IT
                              orderDateTime: new DateTime.now(),
                              orderPickupTime: orderPickupTimeController.text,
                              orderStatus: orderStatusController.text,
                              paymentId: "");
                          newOrder.update;
                          print("Add snackbar/notif success: true");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminHome(index: 2)));
                          var snackBar =
                              SnackBar(content: Text('Yay! It Success.'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    )),
              ],
            ),
          ),
        ]));
  }

  void _orderEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: AppTheme.maroon,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure you want to delete it?",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deleteOrder(context);
                        var snackBar =
                            SnackBar(content: Text('Yay! It Success.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // TODO: MAKE SURE ITS BACK TO ALL COURIER
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminHome(index: 2)));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future deleteOrder(context) async {
    final doc = FirebaseFirestore.instance
        .collection('order')
        .doc(widget.order.getOrderId);

    return await doc.delete();
  }
}

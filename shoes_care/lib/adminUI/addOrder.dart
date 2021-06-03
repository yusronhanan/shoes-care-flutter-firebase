import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/model/courier.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/model/order.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/payment.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class AddOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddOrderPageState();
  }
}

class AddOrderPageState extends State<AddOrderPage> {
  //get list from database
  Future resultsCourierLoaded;
  List courierList = [];

  Future resultsMenuOrderLoaded;
  List menuOrderList = [];

  Future resultsPaymenyLoaded;
  List paymentList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsCourierLoaded = getCourierStreamSnapshots();
    resultsMenuOrderLoaded = getMenuOrderStreamSnapshots();
    resultsPaymenyLoaded = getPaymentStreamSnapshots();
  }
  getCourierStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('courier')
        .get();
    setState(() {
      courierList = List.from(data.docs);
    });
    return "complete";
  }
  getMenuOrderStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('menuorder')
        .get();
    setState(() {
      menuOrderList = List.from(data.docs);
    });
    return "complete";
  }
  getPaymentStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('payment')
        .get();
    setState(() {
      paymentList = List.from(data.docs);
    });
    return "complete";
  }

  final TextEditingController adminIdController = TextEditingController();
  final TextEditingController courierIdController = TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController menuOrderTypeController = TextEditingController();
  final TextEditingController orderAddressController = TextEditingController();
  final TextEditingController orderPickupTimeController =
      TextEditingController();

  final TextEditingController orderStatusController = TextEditingController();
  final TextEditingController orderDateTimeController = TextEditingController();
  DateTime orderDateTimeValue = DateTime.now();
  final TextEditingController paymentIdController = TextEditingController();


  setEmpty() {
    adminIdController.clear();
    courierIdController.clear();
    customerIdController.clear();
    menuOrderTypeController.clear();
    orderAddressController.clear();
    orderDateTimeController.clear();
    orderPickupTimeController.clear();
    orderStatusController.clear();
    paymentIdController.clear();
    // paymentIdController = 'Cash';
    orderDateTimeValue = DateTime.now();
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 6));

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: _endDate,
    );

    if (picked != null)
      setState(() => {
            orderDateTimeController.text =
                DateFormat('dd/MM/yyyy').format(picked).toString(),
            orderDateTimeValue = picked
          });
  }

  @override
  Widget build(BuildContext context) {
    //set adminId as a current loggedIn user admin
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    // final uid = user.uid;
    adminIdController.text = user.email;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 1200,
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

                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add Order',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add new order and give good performance to the customer',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
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
                        labelText: 'Customer Email',
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
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          controller: courierIdController,
                          readOnly: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Courier',
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
                                  .motorcycle), // myIcon is a 48px-wide widget.
                            ),
                            suffixIcon: PopupMenuButton<dynamic>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (dynamic value) {
                                courierIdController.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return courierList.map<PopupMenuItem<dynamic>>((dynamic item) {
                                  var value = Courier.fromSnapshot(item);
                                  return new PopupMenuItem(
                                      child: new Text(value.getCourierName)
                                      , value: value.getEmail);
                                }).toList();
                              },
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          controller: menuOrderTypeController,
                          readOnly: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Menu Order Type',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey)),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(Icons.water_damage), // myIcon is a 48px-wide widget.
                            ),
                            suffixIcon: PopupMenuButton<dynamic>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (dynamic value) {
                                menuOrderTypeController.text = value;
                              },

                              itemBuilder: (BuildContext context) {
                                return menuOrderList.map<PopupMenuItem<dynamic>>((dynamic item) {
                                  var value = MenuOrder.fromSnapshot(item);
                                  return new PopupMenuItem(
                                      child: new Text(value.getMenuOrderType + " - "
                                          + formatCurrency.format(value.getMenuOrderPrice)
                                          + " - "+ value.getMenuOrderDuration.toString() +" Days")
                                      , value: value.getMenuOrderType);
                                }).toList();
                              },
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: orderAddressController,
                      maxLines: 3,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
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
                    child: InkWell(
                      onTap: () {
                        _selectDate(); // Call Function that has showDatePicker()
                      },
                      child: IgnorePointer(
                        child: TextField(
                          controller: orderDateTimeController,
                          readOnly: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Order Pickup Date",
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
                                  .date_range), // myIcon is a 48px-wide widget.
                            ),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(Icons
                                  .arrow_drop_down), // myIcon is a 48px-wide widget.
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          controller: orderPickupTimeController,
                          readOnly: true,
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
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(Icons
                                  .access_time), // myIcon is a 48px-wide widget.
                            ),
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                orderPickupTimeController.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return <String>[
                                  '10:00',
                                  '13:00',
                                  '17:00',
                                  '20:00'
                                ].map<PopupMenuItem<String>>((String value) {
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
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          controller: orderStatusController,
                          readOnly: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Order Status",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey)),
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                orderStatusController.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return <String>[
                                  'New Order',
                                  'Pick up',
                                  'Progress',
                                  'Deliver',
                                  'Complete'
                                ].map<PopupMenuItem<String>>((String value) {
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
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          controller: paymentIdController,
                          readOnly: true,
                          style: TextStyle(fontSize: 18),
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
                            suffixIcon: PopupMenuButton<dynamic>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (dynamic value) {
                                paymentIdController.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return paymentList.map<PopupMenuItem<dynamic>>((dynamic item) {
                                  var value = Payment.fromSnapshot(item);
                                  return new PopupMenuItem(
                                      child: new Text(value.getPaymentName)
                                      , value: value.getPaymentName);
                                }).toList();
                              },
                            ),
                          ),
                        )),
                      ],
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
                            final newOrder = Order(
                                orderId: "",
                                adminId: adminIdController.text,
                                courierId: courierIdController.text,
                                customerId: customerIdController.text,
                                menuOrderType: menuOrderTypeController.text,
                                orderAddress: orderAddressController.text,
                                // TODO: TAKE CARE OF IT
                                orderDateTime: orderDateTimeValue,
                                orderPickupTime: orderPickupTimeController.text,
                                orderStatus: orderStatusController.text,
                                paymentId: paymentIdController.text);
                            newOrder.insert.then((value) {
                              // ignore: deprecated_member_use
                              var snackBar =
                                  SnackBar(content: Text('It is added.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setEmpty();
                            }).catchError((error) {
                              //snackbar fail
                              // ignore: deprecated_member_use
                              var snackBar = SnackBar(
                                  content:
                                      Text('Oh sorry. It fail, try again !'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    orderDateTimeController.dispose();
    super.dispose();
  }
}

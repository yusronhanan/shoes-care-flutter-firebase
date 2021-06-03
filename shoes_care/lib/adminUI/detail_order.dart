import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/courier.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/model/order.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/payment.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

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
  final TextEditingController orderPickupTimeController = TextEditingController();

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
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: _endDate,
    );

    if (picked != null) {
      setState(() =>
      {
        orderDateTimeController.text =
            DateFormat('dd/MM/yyyy').format(picked).toString(),
        orderDateTimeValue = picked
      });
    }
  }
  int i = 0;


  @override
  Widget build(BuildContext context) {

    final String idController = widget.order.getOrderId;
    if(i == 0) {
      adminIdController.text = widget.order.getAdminId;
      courierIdController.text = widget.order.courierId;
      customerIdController.text = widget.order.getCustomerId;
      menuOrderTypeController.text = widget.order.getMenuOrderType;
      orderAddressController.text = widget.order.getOrderAddress;
      orderPickupTimeController.text = widget.order.getOrderPickupTime;

      orderStatusController.text = widget.order.getOrderStatus;
      // orderDateTimeController = TextEditingController();
      setState(() =>
      {
        _startDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.order.getOrderDateTime.toString()),
          orderDateTimeController.text =
            DateFormat('dd/MM/yyyy').format(widget.order.getOrderDateTime).toString(),
        orderDateTimeValue = widget.order.getOrderDateTime
      });
      paymentIdController.text = widget.order.getPaymentId;
      i++;
    }

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
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Edit Order #'+idController,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                              orderDateTime: orderDateTimeValue,
                              orderPickupTime: orderPickupTimeController.text,
                              orderStatus: orderStatusController.text,
                              paymentId: paymentIdController.text);
                          newOrder.update;
                          Navigator.of(context).pushReplacementNamed('/allCompleteOrder');
                          var snackBar =
                              SnackBar(content: Text('It\'s updated'));
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
                            SnackBar(content: Text('It\'s deleted.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pushReplacementNamed('/allCompleteOrder');

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

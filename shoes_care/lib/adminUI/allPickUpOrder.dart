import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/adminUI/order_card.dart';

// ignore: must_be_immutable
class AllPickUpOrderPage extends StatefulWidget {

  @override
  _AllPickUpOrderState createState() => _AllPickUpOrderState();
}

class _AllPickUpOrderState extends State<AllPickUpOrderPage> {
  String currentStatus = "Pick up";
  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  Future resultsMenuOrderLoaded;
  List menuOrderList = [];

  Future resultsPaymentLoaded;
  List paymentList = [];

  Future resultsCourierLoaded;
  List courierList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getDataStreamSnapshots();
    resultsCourierLoaded = getCourierStreamSnapshots();
    resultsMenuOrderLoaded = getMenuOrderStreamSnapshots();
    resultsPaymentLoaded = getPaymentStreamSnapshots();

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
  getMenuOrderStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('menuorder')
        .get();
    setState(() {
      menuOrderList = List.from(data.docs);
    });
    return "complete";
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
  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    // var showResultsAfterStatus = [];
    //
    // for (var ss in _allResults) {
    //   var orderStatus = Order.fromSnapshot(ss).getOrderStatus.toLowerCase();
    //
    //   if(orderStatus.contains(currentStatus.toLowerCase())) {
    //     showResultsAfterStatus.add(ss);
    //   }
    // }
    var showResults = [];

    if (_searchController.text != "") {
      for (var ss in _allResults) {
        var orderId = Order.fromSnapshot(ss).getOrderId.toLowerCase();
        var orderMenuType = Order.fromSnapshot(ss).getMenuOrderType.toLowerCase();
        var customerId = Order.fromSnapshot(ss).getCustomerId.toLowerCase();

        if (orderId.contains(_searchController.text.toLowerCase()) || orderMenuType.contains(_searchController.text.toLowerCase()) || customerId.contains(_searchController.text.toLowerCase())) {
            showResults.add(ss);
          }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getDataStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('order')
        .where('order_status', isEqualTo: currentStatus)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Text("Pick up Order Data", style: TextStyle(fontSize: 20)),
          Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.maroon),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.maroon),
                  ),
                  prefixIcon: Icon(Icons.search, color: AppTheme.maroon)),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _resultsList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildOrderCard(context, _resultsList[index], courierList, menuOrderList, paymentList),
          )),
        ],
      ),
    );
  }
}

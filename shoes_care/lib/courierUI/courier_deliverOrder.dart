import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/courierUI/complete_order_card.dart';
import 'package:shoes_care/courierUI/deliver_order_card.dart';
import 'package:shoes_care/model/order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeliverOrderPage extends StatefulWidget {
  @override
  _DeliverOrderState createState() => _DeliverOrderState();
}

class _DeliverOrderState extends State<DeliverOrderPage> {
  TextEditingController _searchController = TextEditingController();

  Future resultsCompleteLoaded;
  Future resultsNotCompleteLoaded;

  Future resultsMenuOrderLoaded;
  List menuOrderList = [];

  Future resultsPaymentLoaded;
  List paymentList = [];

  List _allNotComplete = [];
  List _allComplete = [];
  List _resultsListComplete = [];
  List _resultsListNotComplete = [];

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
    resultsCompleteLoaded = getDataStreamSnapshotsComplete();
    resultsNotCompleteLoaded = getDataStreamSnapshotsNotComplete();

    resultsMenuOrderLoaded = getMenuOrderStreamSnapshots();
    resultsPaymentLoaded = getPaymentStreamSnapshots();


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
  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showCompleteResults = [];
    var showNotCompleteResults = [];
    for (var or in _allComplete) {
      var status = Order
          .fromSnapshot(or)
          .orderStatus
          .toLowerCase();

      if (status.contains('complete')) {
        showCompleteResults.add(or);
      } else if (status.contains('deliver')){
        showNotCompleteResults.add(or);
      }
    }

    setState(() {
      _resultsListComplete = showCompleteResults;
      _resultsListNotComplete = showNotCompleteResults;
    });
  }

  getDataStreamSnapshotsComplete() async {
    // 'New Order',
    // 'Pick up',
    // 'Progress',
    // 'Deliver',
    // 'Complete'
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String email = _firebaseAuth.currentUser.email;

    var data = await FirebaseFirestore.instance
        .collection('order')
        .where('courier_id', isEqualTo: email)
        .get();
    setState(() {
      _allComplete = data.docs;
    });
    return "complete";
  }

  getDataStreamSnapshotsNotComplete() async {
    // 'New Order',
    // 'Pick up',
    // 'Progress',
    // 'Deliver',
    // 'Complete'
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String email = _firebaseAuth.currentUser.email;

    var data = await FirebaseFirestore.instance
        .collection('order')
        .where('courier_id', isEqualTo: email)
        .get();
    setState(() {
      _allNotComplete = data.docs;
      // print(_allNotComplete);
    });
    searchResultsList();

    return "not complete";
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Deliver Order',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          endDrawer: Drawer(
            child: ListView(),
          ),
          body:
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  ExpansionTile(
                    title: Text('Deliver Order'),
                    initiallyExpanded: (_resultsListNotComplete.length == 0),
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height - 300,
                        child: ListView.builder(
                          itemCount: _resultsListNotComplete.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildDeliverOrderCard(context, _resultsListNotComplete[index], menuOrderList, paymentList),
                          shrinkWrap: true,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Complete order'),
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height - 300,
                        child: ListView.builder(
                          itemCount: _resultsListComplete.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildCompleteOrderCard(context, _resultsListComplete[index], menuOrderList),
                          shrinkWrap: true,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

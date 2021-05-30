import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/courierUI/pickup_order_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'neworder_order_card.dart';

class PickupOrderPage extends StatefulWidget {
  @override
  _PickupOrderState createState() => _PickupOrderState();
}

class _PickupOrderState extends State<PickupOrderPage> {
  TextEditingController _searchController = TextEditingController();

  Future resultsCompleteLoaded;
  Future resultsNotCompleteLoaded;

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
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showCompleteResults = [];
    var showNotCompleteResults = [];
    for (var or in _allComplete) {
      // TODO: search by all attribute
      var status = Order
          .fromSnapshot(or)
          .orderStatus
          .toLowerCase();

      if (status.contains('new order')) {
        showCompleteResults.add(or);
      } else if (status.contains('pick up')) {
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
              'Pick up Order',
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
                    title: Text('Pick up Order'),
                    initiallyExpanded: (_resultsListNotComplete.length == 0),
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height - 300,
                        child: ListView.builder(
                          itemCount: _resultsListNotComplete.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildPickupOrderCard(context, _resultsListNotComplete[index]),
                          shrinkWrap: true,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('New Order'),
                    initiallyExpanded: (_resultsListComplete.length == 0),
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height - 300,
                        child: ListView.builder(
                          itemCount: _resultsListComplete.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildNewOrderCard(context, _resultsListComplete[index]),
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

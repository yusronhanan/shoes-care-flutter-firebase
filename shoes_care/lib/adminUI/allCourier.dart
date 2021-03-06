import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/courier.dart';
import 'package:shoes_care/adminUI/courier_card.dart';

class AllCourierPage extends StatefulWidget {
  @override
  _AllCourierState createState() => _AllCourierState();
}

class _AllCourierState extends State<AllCourierPage> {
  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

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
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var ss in _allResults) {
        var title = Courier.fromSnapshot(ss).courierName.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
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
        .collection('courier')
        .orderBy('courier_name')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
    ),
    body: Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Text("Courier Data", style: TextStyle(fontSize: 20)),
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
                buildCourierCard(context, _resultsList[index]),
          )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Color(0xff9e2229), shape: BoxShape.circle),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/addCourier');
                  },
                  icon: Icon(Icons.add),
                ),
              )),
        ],
      ),
    ),
    );
  }
}

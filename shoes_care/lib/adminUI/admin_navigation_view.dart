import 'package:flutter/material.dart';
import 'package:shoes_care/adminUI/allCustomer.dart';
import 'package:shoes_care/adminUI/allDeliverOrder.dart';
import 'package:shoes_care/adminUI/allNewOrder.dart';
import 'package:shoes_care/adminUI/allOrder.dart';
import 'package:shoes_care/adminUI/allPickUpOrder.dart';
import 'package:shoes_care/adminUI/allProgressOrder.dart';
import 'package:shoes_care/app_theme.dart';

import 'package:shoes_care/adminUI/admin_home.dart';
// import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/adminUI/admin_profile.dart';
import 'package:shoes_care/adminUI/allCourier.dart';
import 'package:shoes_care/adminUI/admin_setting.dart';

// ignore: must_be_immutable
class AdminHome extends StatefulWidget {
  int index;
  AdminHome({this.index});
  @override
  State<StatefulWidget> createState() {
    return _AdminHomeState();
  }
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AllNewOrderPage(),//AllOrderPage(status: "New Order",key: UniqueKey()), //TODO REPLACE NEW ORDER
    AllPickUpOrderPage(),//AllOrderPage(status: "Pick up",key: UniqueKey()), //TODO REPLACE PICK UP ORDER
    AllProgressOrderPage(),//AllOrderPage(status: "Progress",key: UniqueKey()), //TODO REPLACE PROGRESS ORDER
    AllDeliverOrderPage(),//AllOrderPage(status: "Deliver",key: UniqueKey()), //TODO REPLACE DELIVER ORDER
    AdminSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.index != null) {
        _currentIndex = widget.index;
        widget.index = null;
      }
    });

    // final newTrip = new Trip(null, null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, foregroundColor: AppTheme.maroon,
        toolbarHeight: 10,
        // title: Text("Travel Budget App"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => NewTripLocationView(trip: newTrip,)),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.maroon,
          backgroundColor: Colors.black,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon:
              new Icon(Icons.add_shopping_cart), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
              new Text("New"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon:
              new Icon(Icons.sports_motorsports), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
              new Text("Pick up"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.local_laundry_service), //, color: Colors.white
              // ignore: deprecated_member_use
              title: new Text(
                  "Progress"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.motorcycle), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
                  new Text("Deliver"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings), //, color: Colors.white
              // ignore: deprecated_member_use
              title: new Text("Setting"), //,style: TextStyle(color: Colors.white,)
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

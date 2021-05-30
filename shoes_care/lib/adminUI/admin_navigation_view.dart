import 'package:flutter/material.dart';
import 'package:shoes_care/adminUI/allDeliverOrder.dart';
import 'package:shoes_care/adminUI/allNewOrder.dart';
import 'package:shoes_care/adminUI/allPickUpOrder.dart';
import 'package:shoes_care/adminUI/allProgressOrder.dart';
import 'package:shoes_care/app_theme.dart';

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
    AllNewOrderPage(),
    AllPickUpOrderPage(),
    AllProgressOrderPage(),
    AllDeliverOrderPage(),
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
              new Icon(Icons.add_shopping_cart),
              // ignore: deprecated_member_use
              title:
              new Text("New"),
            ),
            BottomNavigationBarItem(
              icon:
              new Icon(Icons.sports_motorsports),
              // ignore: deprecated_member_use
              title:
              new Text("Pick up"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.local_laundry_service),
              // ignore: deprecated_member_use
              title: new Text(
                  "Progress"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.motorcycle),
              // ignore: deprecated_member_use
              title:
                  new Text("Deliver"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              // ignore: deprecated_member_use
              title: new Text("Setting"),
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

import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/courierUI/courier_deliverOrder.dart';

import 'package:shoes_care/courierUI/profile.dart';
import 'package:shoes_care/courierUI/courier_pickupOrder.dart';

// ignore: must_be_immutable
class CourierHome extends StatefulWidget {
  int index;
  CourierHome({this.index});
  @override
  State<StatefulWidget> createState() {
    return _CourierHomeState();
  }
}

class _CourierHomeState extends State<CourierHome> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    DeliverOrderPage(),
    PickupOrderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.index != null) {
        _currentIndex = widget.index;
        widget.index = null;
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, foregroundColor: AppTheme.maroon,
        toolbarHeight: 10,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppTheme.maroon,
          backgroundColor: Colors.black,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon:
                  new Icon(Icons.motorcycle_rounded),
              // ignore: deprecated_member_use
              title: new Text(
                  "Deliver Order"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart_rounded),
              // ignore: deprecated_member_use
              title: new Text("Pickup Order"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              // ignore: deprecated_member_use
              title:
                  new Text("My Profile"),
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

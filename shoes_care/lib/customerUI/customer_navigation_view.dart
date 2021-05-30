import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/customerUI/home.dart';
import 'package:shoes_care/customerUI/profile.dart';
import 'package:shoes_care/customerUI/customer_allOrder.dart';

// ignore: must_be_immutable
class CustomerHome extends StatefulWidget {
  int index;
  CustomerHome({this.index});
  @override
  State<StatefulWidget> createState() {
    return _CustomerHomeState();
  }
}

class _CustomerHomeState extends State<CustomerHome> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    MyAllOrderPage(),
    CustomerHomePage(),
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
                  new Icon(Icons.shopping_cart_rounded),
              // ignore: deprecated_member_use
              title: new Text(
                  "My Order"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              // ignore: deprecated_member_use
              title: new Text("Home"),
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

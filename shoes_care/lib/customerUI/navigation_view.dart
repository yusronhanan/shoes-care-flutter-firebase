import 'package:flutter/material.dart';

import 'package:shoes_care/customerUI/home.dart';
// import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/customerUI/profile.dart';
import 'package:shoes_care/adminUI/allCourier.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    AllCourierPage(), //MyOrderPage()
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // final newTrip = new Trip(null, null, null, null, null, null);
    return Scaffold(
      // appBar: AppBar(
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
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart_rounded),
              // ignore: deprecated_member_use
              title: new Text("Order"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              // ignore: deprecated_member_use
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              // ignore: deprecated_member_use
              title: new Text("Profile"),
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

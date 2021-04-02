import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';

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
          selectedItemColor: AppTheme.maroon,
          backgroundColor: Colors.black,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon:
                  new Icon(Icons.shopping_cart_rounded), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
                  new Text("Order"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home), //, color: Colors.white
              // ignore: deprecated_member_use
              title: new Text("Home"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
                  new Text("Profile"), //,style: TextStyle(color: Colors.white,)
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
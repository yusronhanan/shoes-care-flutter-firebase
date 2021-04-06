import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/adminUI/allOrder.dart';

import 'package:shoes_care/customerUI/home.dart';
// import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/customerUI/profile.dart';
import 'package:shoes_care/customerUI/My_order.dart';

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
    MyOrder(),
    // AllOrderPage(), //Should move to admin nav view
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
              title: new Text(
                  "My Order"), //,style: TextStyle(color: Colors.white,)
            ),
            // BottomNavigationBarItem(
            //   icon:
            //       new Icon(Icons.shopping_cart_rounded), //, color: Colors.white
            //   // ignore: deprecated_member_use
            //   title: new Text(
            //       "All Order"), //,style: TextStyle(color: Colors.white,)
            // ),
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

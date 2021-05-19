import 'package:flutter/material.dart';
import 'package:shoes_care/adminUI/allOrder.dart';
import 'package:shoes_care/app_theme.dart';

import 'package:shoes_care/adminUI/admin_home.dart';
// import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/adminUI/admin_profile.dart';
import 'package:shoes_care/adminUI/allCourier.dart';

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
  int _currentIndex = 2;
  final List<Widget> _children = [
    AllCourierPage(), //MyOrderPage()
    AllOrderPage(),
    //TODO: AllCustomerPage(),
    AdminHomePage(),
    AdminProfilePage(),
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
              icon: new Icon(Icons.motorcycle), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
                  new Text("Courier"), //,style: TextStyle(color: Colors.white,)
            ),
            BottomNavigationBarItem(
              icon:
                  new Icon(Icons.shopping_cart_rounded), //, color: Colors.white
              // ignore: deprecated_member_use
              title:
                  new Text("Order"), //,style: TextStyle(color: Colors.white,)
            ),
            // TODO: add AllCustomer()
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.person_add), //, color: Colors.white
            //   // ignore: deprecated_member_use
            //   title: new Text(
            //       "Customer"), //,style: TextStyle(color: Colors.white,)
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
                  new Text("My Profile"), //,style: TextStyle(color: Colors.white,)
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/adminUI/addCourier.dart';
import 'package:shoes_care/adminUI/addOrder.dart';
import 'package:shoes_care/adminUI/admin_navigation_view.dart';
import 'package:shoes_care/adminUI/allCourier.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:shoes_care/customerUI/profile.dart';
import 'package:shoes_care/welcome.dart';
// import 'package:shoes_care/customerUI/home.dart';
import 'package:shoes_care/login.dart';
import 'package:shoes_care/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoes_care/authentication_service.dart';
import 'package:shoes_care/customerUI/customer_navigation_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      // ignore: deprecated_member_use
      cursorColor: AppTheme.maroon,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UI Kit',
          initialRoute: '/home',
          routes: {
            '/home': (context) => HomeController(),

            //can not '/'. will cause error
            '/welcome': (context) => WelPage(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            // '/home': (context) => HomePage(),
            // '/customerUI/customer': (context) => ProfilePage(),
            //for role admin
            '/addCourier': (context) => AddCourierPage(),
            '/allCourier': (context) => AllCourierPage(),

            '/addOrder': (context) => AddOrderPage(),
            '/allOrder': (context) => AllCourierPage(),
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.amber,
          ),
          home: HomeController(),
        ));
  }
}

Future<String> getRole() async {
  // do something
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email = _firebaseAuth.currentUser.email;

  bool isAdmin = false;
  CollectionReference admin = FirebaseFirestore.instance.collection('admin');
  await admin
      .where('admin_email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            if (querySnapshot.docs.length > 0)
              {
                // empty
                isAdmin = true
              }
          });
  if (!isAdmin) {
    bool isCourier = false;
    CollectionReference courier =
        FirebaseFirestore.instance.collection('courier');
    await courier
        .where('courier_email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.docs.length > 0)
                {
                  // empty
                  isCourier = true
                }
            });
    if (!isCourier) {
      bool isCustomer = false;

      CollectionReference customer =
          FirebaseFirestore.instance.collection('customer');
      await customer
          .where('customer_email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                if (querySnapshot.docs.length > 0)
                  {
                    // empty
                    isCustomer = true
                  }
              });

      if (isCustomer) {
        return 'customer';
      } else {
        return 'none';
      }
    } else {
      return 'courier';
    }
  } else {
    return 'admin';
  }
}

class HomeController extends StatelessWidget {
  const HomeController({
    Key key,
  }) : super(key: key);
  // @override
// Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();
//
//     Widget nav = WelPage();
//     if (firebaseUser != null) {
//       // getRole()
//       // .then((value)  {
//       //   print("role:"+value);
//       //   if(value == 'admin'){
//       //     nav = AdminHome(index: 1);
//       //   } else if(value == 'courier'){
//       //     nav = CustomerHome(index:1);//CourierHome(index:1)
//       //   } else if(value == 'customer'){
//       //     nav = CustomerHome(index:1);
//       //   }
//       // });
//       return nav;
//       //temporary. it should return to hoempage BASED ON LOGIN INFO (ADMIN, COURIER, CUSTOMER)
//       //change this to CustomerHome or AdminHome : soon CourierHome
//     } else {
//       //   //temporary. it should return warning
//       return WelPage();
//     }
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {

    try {
      return FutureBuilder(
        future: getRole(),
        builder: (BuildContext context, AsyncSnapshot<String> value) {
            Widget nav = WelPage();
            print("role:" + value.data);
            if (value.data == 'admin') {
              nav = AdminHome(index: 1);
            } else if (value.data == 'courier') {
              nav = CustomerHome(index: 1); //CourierHome(index:1)
            } else if (value.data == 'customer') {
              nav = CustomerHome(index: 1);
            }
            return nav;

        },
      );
    }
    catch(e) {
      print('Future Builder -Nav:'+e);
      return WelPage();
    }
    }
    return WelPage();

  }
}

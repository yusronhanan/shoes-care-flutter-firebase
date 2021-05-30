import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/adminUI/addCourier.dart';
import 'package:shoes_care/adminUI/addOrder.dart';
import 'package:shoes_care/adminUI/addPayment.dart';
import 'package:shoes_care/adminUI/admin_navigation_view.dart';
import 'package:shoes_care/adminUI/allCourier.dart';
import 'package:shoes_care/adminUI/paymentSetting.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/courierUI/courier_navigation_view.dart';
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

            '/allPayment': (context) => PaymentSettingPage(),
            '/addPayment': (context) => AddPaymentPage(),

            // '/addMenuOrder': (context) => AddMenuOrderPage(),
            // '/allMenuOrder': (context) => MenuOrderSetting(),
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

class HomeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return HomeControllerState();
  }
}

class HomeControllerState extends State<HomeController> {
  Future userRole;

  @override
  void initState(){
    super.initState();
    userRole = _getRole();
  }

  Future<String> _getRole() async {
    return await getRole();
  }
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    switch (firebaseUser) {
      case null:
        return WelPage();
        break;
      default:
        return FutureBuilder(
          future: _getRole(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // Widget nav = WelPage();
              if(snapshot.hasData){
            print("role:" + snapshot.data);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return WelPage();
                break;
              case ConnectionState.done:
                return (snapshot.data == 'admin' ? AdminHome(index: 2) : snapshot
                    .data == 'courier' ? CourierHome(index: 1) : snapshot
                    .data == 'customer' ? CustomerHome(index: 1) : WelPage());
                break;
              default:
                return WelPage();
            }
            } else{
                return WelPage();
              }
                  // return nav;

          },
        );
    }
    // return WelPage();

  }
}

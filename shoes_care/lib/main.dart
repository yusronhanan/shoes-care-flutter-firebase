import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/adminUI/addCourier.dart';
import 'package:shoes_care/adminUI/allCourier.dart';
// import 'package:shoes_care/customerUI/profile.dart';
import 'package:shoes_care/welcome.dart';
// import 'package:shoes_care/customerUI/home.dart';
import 'package:shoes_care/login.dart';
import 'package:shoes_care/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoes_care/authentication_service.dart';
import 'package:shoes_care/customerUI/navigation_view.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
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
            // '/welcome': (context) => WelPage(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            // '/home': (context) => HomePage(),
            // '/customerUI/customer': (context) => ProfilePage(),
            //for role admin
            '/addCourier': (context) => AddCourierPage(),
            '/allCourier': (context) => AllCourierPage(),
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.amber,
          ),
          home: HomeController(),
        ));
  }
}

class HomeController extends StatelessWidget {
  const HomeController({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //temporary. it should return to hoempage
      return Home();
      // Navigator.pushNamed(context, '/welcome');
    } else {
      //   //temporary. it should return warning
      // Navigator.pushNamed(context, '/register');
      return WelPage();
    }
  }
}

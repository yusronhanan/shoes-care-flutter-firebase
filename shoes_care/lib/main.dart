import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/login.dart';
import 'package:shoes_care/welcome.dart';
import 'package:shoes_care/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoes_care/authentication_service.dart';
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
          routes: {
            //can not '/'. will cause error
            '/welcome': (context) => WelPage(), //AnimatedBottomBar()
            '/register': (context) => RegisterPage(), //AnimatedBottomBar()
            '/login': (context) => LoginPage(),
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.amber,
          ),
          home: AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //temporary. it should return to hoempage
      // return WelPage();
      // Navigator.pushNamed(context, '/welcome');
      return WelPage();
    } else {
      //temporary. it should return warning
      // Navigator.pushNamed(context, '/register');
      return LoginPage();
    }
  }
}

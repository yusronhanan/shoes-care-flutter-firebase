import 'package:flutter/material.dart';

var assetImage = AssetImage('assets/snc_no_backgroundHD.png');
var logo = Image(
  image: assetImage,
);

class WelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomePage();
  }
}

class WelcomePage extends State<WelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 200,
              width: 600,
              decoration: BoxDecoration(
                // border: Border.all(width: 2.0),
                image: DecorationImage(
                    image: AssetImage('assets/snc_no_backgroundHD.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text('Sign In',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/grocerry/auth');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text('Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/grocerry/auth');
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: <Widget>[
                //     Text(
                //       'Language : ',
                //       style: TextStyle(
                //           fontSize: 18, fontWeight: FontWeight.normal),
                //     ),
                //     SizedBox(
                //       width: 8,
                //     ),
                //     FlatButton(
                //       onPressed: () {},
                //       child: Text(
                //         'English',
                //         style: TextStyle(
                //             fontSize: 18, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

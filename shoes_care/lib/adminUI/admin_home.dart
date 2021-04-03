import 'package:flutter/material.dart';
// import 'package:shoes_care/adminUI/allCourier.dart';
// import 'package:shoes_care/app_theme.dart';
// import 'package:shoes_care/customerUI/profile.dart';

var assetImage = AssetImage('assets/high.jpg');
var high = Image(
  image: assetImage,
);

var jordan = AssetImage('assets/jord.jpg');
var jord = Image(
  image: assetImage,
);

var logsss = AssetImage('assets/snc_kiri.png');
var logo = Image(
  image: assetImage,
);

class AdminHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminHomePageState();
  }
}

class AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 1),
                      alignment: Alignment.topLeft,
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 3.0,
                        // ),
                        image: DecorationImage(
                          image: AssetImage('assets/snc_kiri.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 70),
                      child: Text(
                        'The best treatment for your shoes                ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 200,
                        width: 350,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Discount 50%',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/high.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 200,
                        width: 350,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Let\'s Order',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/jord.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ]),
            ], //your list view content here
          ))),

          Container(), // some bottom content
        ],
      ),
      //Bottom Nav Bar
    );
  }
}

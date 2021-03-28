import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        children: (
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("belumhehe"),
                )
              ]
              child: TextAlign.right(
                "Salsabilla Rinaldi"
                style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            )
          )
        )
        // body: ListView(
        //   children: <Widget>[
        //     Container(
        //       height: 409,
        //       decoration: BoxDecoration(
        //           boxShadow: [
        //             new BoxShadow(
        //               color: Colors.black26,
        //               offset: new Offset(0.0, 2.0),
        //               blurRadius: 25.0,
        //             )
        //           ],
        //           color: Colors.white,
        //       alignment: Alignment.topCenter,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
                      
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Account Information',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 32, bottom: 8),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        child: Text(
                          'Email : salsabilarinaldi@gmail.com'
                        )
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        child: Text(
                          'Phone : 081365437165'
                        )
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        child: Text(
                          'instagram : salsabilarinaldi'
                        )
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Account Details',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Container(
                  //       margin: EdgeInsets.all(16),
                  //       decoration: BoxDecoration(
                  //           color: Color(0xff9e2229), shape: BoxShape.circle),
                  //       child: IconButton(
                  //         color: Colors.white,
                  //         onPressed: () {
                  //           print(
                  //               emailController.text + passwordController.text);
                  //           context.read<AuthenticationService>().signIn(
                  //               email: emailController.text,
                  //               password: passwordController.text);
                  //         },
                  //         icon: Icon(Icons.arrow_forward),
                  //       ),
                  //     )),
                ],
              ),
            ),
          ],
        ));
  }
}
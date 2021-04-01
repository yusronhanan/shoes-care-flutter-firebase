import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:shoes_care/model/courier.dart';

class AddCourierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegPageState();
  }
}

class RegPageState extends State<AddCourierPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nopolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 800,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(0.0, 2.0),
                      blurRadius: 25.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/allCourierData');
                          },
                          child: Text(
                            'All Courier Data',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(16),
                      //   // ignore: deprecated_member_use
                      //   child: FlatButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       'Sign Up',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         color: Color(0xff9e2229),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add Courier',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add courier for shoes care good performance',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 32, bottom: 8),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'E-Mail Address',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: phoneNumController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Address',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: nopolController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'NOPOL',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Color(0xff9e2229), shape: BoxShape.circle),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            print(nameController.text +
                                emailController.text +
                                phoneNumController.text +
                                addressController.text +
                                passwordController.text +
                                nopolController.text);

                            final newCourier = Courier(
                                courierId: "",
                                courierName: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                courierPhone: phoneNumController.text,
                                courierAddress: addressController.text,
                                courierNOPOL: nopolController.text);
                            newCourier.insert.then((value) {
                              //TO DO ADD SNACKBAR NOTIF
                              // if(value){
                              //snackbar success
                              // } else{
                              //snackbar fail
                              // }
                              print("Add snackbar/notif success: $value");
                            }).catchError((error) {
                              //snackbar fail
                              print("Add snackbar/notif fail: $error");
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/model/courier.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nopolController = TextEditingController();
  String courierId = "";
  void _fetchUserData() async {
    // do something
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    // final uid = user.uid;
    final email = user.email;
    // here you write the codes to input the data into firestore
    Courier myProfileData = Courier(
        courierId: "",
        courierName: "",
        email: email,
        password: "",
        courierPhone: "",
        courierAddress: "",
        courierNOPOL: "");
    await myProfileData.syncDataByEmail(email);
    courierId = myProfileData.getCourierId;
    nameController.text = myProfileData.getCourierName;
    emailController.text = myProfileData.getEmail;
    phoneNumController.text = myProfileData.getCourierPhone;
    addressController.text = myProfileData.getCourierAddress;
    nopolController.text = myProfileData.getCourierNOPOL;
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserData();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
                size: 30,
              ),
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                //logout dialog
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: AppTheme.maroon,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // ignore: deprecated_member_use
                                RaisedButton(
                                  child: Text('Yes'),
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    context.read<AuthenticationService>().signOut();
                                    Navigator.of(context).pop();

                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );

              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 900, //MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
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
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'My Account',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      '',
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: emailController,
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'E-Mail Address',
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
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 32, bottom: 8),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                        labelText: 'Phone Number',
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
                      maxLines: 3,
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Address',
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
                        labelText: 'NOPOL',
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
                        labelText: 'Password',
                        helperText:
                            'Let this empty if you don\'t want to update your password',
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
                        margin: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            color: AppTheme.maroon, shape: BoxShape.circle),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            print(nameController.text +
                                emailController.text +
                                phoneNumController.text +
                                addressController.text +
                                nopolController.text +
                                passwordController.text);

                            Courier profileCourier = Courier(
                                courierId: courierId,
                                courierName: nameController.text,
                                courierAddress: addressController.text,
                                email: emailController.text,
                                courierPhone: phoneNumController.text,
                                courierNOPOL: nopolController.text,
                                password: passwordController.text);
                            profileCourier.update;
                            var snackBar =
                                SnackBar(content: Text('Yay! It Success.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: Icon(Icons.save),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

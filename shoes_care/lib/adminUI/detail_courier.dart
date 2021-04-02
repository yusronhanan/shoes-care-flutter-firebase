import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
// import 'package:shoes_care/adminUI/allCourier.dart';
import 'package:shoes_care/customerUI/navigation_view.dart';
import 'package:shoes_care/model/courier.dart';

// import 'edit_notes_view.dart';
// import 'package:intl/intl.dart';
// import 'package:auto_size_text/auto_size_text.dart';

class DetailCourierView extends StatefulWidget {
  final Courier courier;

  DetailCourierView({Key key, @required this.courier}) : super(key: key);

  @override
  _DetailCourierViewState createState() => _DetailCourierViewState();
}

class _DetailCourierViewState extends State<DetailCourierView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String idController = widget.courier.getCourierId;

    final TextEditingController nameController =
        TextEditingController(text: widget.courier.getCourierName);
    final TextEditingController emailController =
        TextEditingController(text: widget.courier.getEmail);
    final TextEditingController phoneNumController =
        TextEditingController(text: widget.courier.getCourierPhone);
    final TextEditingController addressController =
        TextEditingController(text: widget.courier.getCourierAddress);
    final TextEditingController nopolController =
        TextEditingController(text: widget.courier.getCourierNOPOL);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                _courierEditModalBottomSheet(context);
              },
            ),
          ],
        ),
        body: ListView(children: <Widget>[
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
                      // child: FlatButton(
                      //   onPressed: () {
                      //     // Navigator.pushNamed(context, '/allCourierData');
                      //   },
                      //   child: Text(
                      //     'All Courier Data',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
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
                    'Edit Courier',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
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
                    maxLines: 3,
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
                          print(idController +
                              nameController.text +
                              emailController.text +
                              phoneNumController.text +
                              addressController.text +
                              nopolController.text);

                          final newCourier = Courier(
                              courierId: idController,
                              courierName: nameController.text,
                              email: emailController.text,
                              password: "",
                              courierPhone: phoneNumController.text,
                              courierAddress: addressController.text,
                              courierNOPOL: nopolController.text);
                          if (newCourier.update) {
                            print("Add snackbar/notif success: true");
                            var snackBar =
                                SnackBar(content: Text('Yay! It Success.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            //snackbar fail
                            print("Add snackbar/notif fail: false");
                            var snackBar = SnackBar(
                                content:
                                    Text('Oh sorry. It fail, try again !'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                    )),
              ],
            ),
          ),
        ]));
  }

  // Widget courierForm() {
  //   final String idController = widget.courier.getCourierId;

  //   final TextEditingController nameController =
  //       TextEditingController(text: widget.courier.getCourierName);
  //   final TextEditingController emailController =
  //       TextEditingController(text: widget.courier.getEmail);
  //   final TextEditingController phoneNumController =
  //       TextEditingController(text: widget.courier.getCourierPhone);
  //   final TextEditingController addressController =
  //       TextEditingController(text: widget.courier.getCourierAddress);
  //   final TextEditingController nopolController =
  //       TextEditingController(text: widget.courier.getCourierNOPOL);

  //   // widget.courier.courierName
  //   return Card(
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           height: 600,
  //           decoration: BoxDecoration(
  //               boxShadow: [
  //                 new BoxShadow(
  //                   color: Colors.black26,
  //                   offset: new Offset(0.0, 2.0),
  //                   blurRadius: 25.0,
  //                 )
  //               ],
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(32),
  //                   bottomRight: Radius.circular(32))),
  //           alignment: Alignment.topCenter,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Container(
  //                     margin: EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.rectangle,
  //                       borderRadius: BorderRadius.all(Radius.circular(8)),
  //                     ),
  //                     // ignore: deprecated_member_use
  //                     // child: FlatButton(
  //                     //   onPressed: () {
  //                     //     // Navigator.pushNamed(context, '/allCourierData');
  //                     //   },
  //                     //   child: Text(
  //                     //     'All Courier Data',
  //                     //     style: TextStyle(
  //                     //       fontSize: 20,
  //                     //       color: Colors.grey,
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                   ),
  //                   // Container(
  //                   //   margin: EdgeInsets.all(16),
  //                   //   // ignore: deprecated_member_use
  //                   //   child: FlatButton(
  //                   //     onPressed: () {},
  //                   //     child: Text(
  //                   //       'Sign Up',
  //                   //       style: TextStyle(
  //                   //         fontSize: 20,
  //                   //         color: Color(0xff9e2229),
  //                   //       ),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(left: 16, top: 8),
  //                 child: Text(
  //                   'Edit Courier',
  //                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
  //                 child: TextField(
  //                   controller: nameController,
  //                   style: TextStyle(fontSize: 18),
  //                   keyboardType: TextInputType.text,
  //                   textCapitalization: TextCapitalization.words,
  //                   decoration: InputDecoration(
  //                     hintText: 'Name',
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //                 child: TextField(
  //                   controller: emailController,
  //                   keyboardType: TextInputType.emailAddress,
  //                   style: TextStyle(fontSize: 18),
  //                   decoration: InputDecoration(
  //                     hintText: 'E-Mail Address',
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //                 child: TextField(
  //                   controller: phoneNumController,
  //                   keyboardType: TextInputType.phone,
  //                   style: TextStyle(fontSize: 18),
  //                   decoration: InputDecoration(
  //                     hintText: 'Phone Number',
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //                 child: TextField(
  //                   maxLines: 3,
  //                   controller: addressController,
  //                   keyboardType: TextInputType.streetAddress,
  //                   style: TextStyle(fontSize: 18),
  //                   decoration: InputDecoration(
  //                     hintText: 'Address',
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //                 child: TextField(
  //                   controller: nopolController,
  //                   style: TextStyle(fontSize: 18),
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     hintText: 'NOPOL',
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey)),
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                   alignment: Alignment.centerRight,
  //                   child: Container(
  //                     margin: EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                         color: Color(0xff9e2229), shape: BoxShape.circle),
  //                     child: IconButton(
  //                       color: Colors.white,
  //                       onPressed: () {
  //                         print(idController +
  //                             nameController.text +
  //                             emailController.text +
  //                             phoneNumController.text +
  //                             addressController.text +
  //                             nopolController.text);

  //                         final newCourier = Courier(
  //                             courierId: idController,
  //                             courierName: nameController.text,
  //                             email: emailController.text,
  //                             password: "",
  //                             courierPhone: phoneNumController.text,
  //                             courierAddress: addressController.text,
  //                             courierNOPOL: nopolController.text);
  //                         if (newCourier.update) {
  //                           print("Add snackbar/notif success: true");
  //                         } else {
  //                           //snackbar fail
  //                           print("Add snackbar/notif fail: false");
  //                         }
  //                       },
  //                       icon: Icon(Icons.edit),
  //                     ),
  //                   )),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _courierEditModalBottomSheet(context) {
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
                        // TO DO: BACK TO ALL COURIER PAGE
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure you want to delete it?",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deleteCourier(context);
                        var snackBar =
                            SnackBar(content: Text('Yay! It Success.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // TO DO: MAKE SURE ITS BACK TO ALL COURIER
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
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
  }

  Future deleteCourier(context) async {
    final doc = FirebaseFirestore.instance
        .collection('courier')
        .doc(widget.courier.getCourierId);

    return await doc.delete();
  }
}

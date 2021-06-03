import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/customer.dart';

class DetailCustomerView extends StatefulWidget {
  final Customer customer;

  DetailCustomerView({Key key, @required this.customer}) : super(key: key);

  @override
  _DetailCustomerViewState createState() => _DetailCustomerViewState();
}

class _DetailCustomerViewState extends State<DetailCustomerView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String idController = widget.customer.getCustomerId;

    final TextEditingController nameController =
        TextEditingController(text: widget.customer.getCustomerName);
    final TextEditingController emailController =
        TextEditingController(text: widget.customer.getEmail);
    final TextEditingController phoneNumController =
        TextEditingController(text: widget.customer.getCustomerPhone);
    final TextEditingController addressController =
        TextEditingController(text: widget.customer.getCustomerAddress);


    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
                size: 30,
              ),
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                _customerEditModalBottomSheet(context);
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
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Edit Customer',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
                  child: TextField(
                    readOnly: true,
                    controller: emailController,
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
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
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
                              addressController.text
                              );

                          final newCustomer = Customer(
                              customerId: idController,
                              customerName: nameController.text,
                              email: emailController.text,
                              password: "",
                              customerPhone: phoneNumController.text,
                              customerAddress: addressController.text,
                              );
                          newCustomer.update;
                          Navigator.of(context).pushReplacementNamed('/allCustomer');

                          var snackBar =
                              SnackBar(content: Text('It\'s updated.'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    )),
              ],
            ),
          ),
        ]));
  }

  void _customerEditModalBottomSheet(context) {
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
                        await deleteCustomer(context);
                        var snackBar =
                            SnackBar(content: Text('It\'s deleted.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pushReplacementNamed('/allCustomer');

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

  Future deleteCustomer(context) async {
    final doc = FirebaseFirestore.instance
        .collection('customer')
        .doc(widget.customer.getCustomerId);

    return await doc.delete();
  }
}

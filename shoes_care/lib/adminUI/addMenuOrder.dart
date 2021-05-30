import 'package:flutter/material.dart';
import 'package:shoes_care/model/menu_order.dart';

class AddMenuOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMenuOrderPageState();
  }
}

class AddMenuOrderPageState extends State<AddMenuOrderPage> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController =TextEditingController();

  setEmpty() {
    typeController.clear();
    durationController.clear();
    priceController.clear();
  }

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
                            Navigator.pushNamed(context, '/allMenuOrder');
                          },
                          child: Text(
                            'All Menu Order Data',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add Menu Order',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Add menu order for shoes care good performance',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
                    child: TextField(
                      controller: typeController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Menu Order Type',
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
                      controller: durationController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Menu Order Duration (day)',
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
                      controller: priceController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Menu Order Price',
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
                            print(
                                typeController.text
                                + durationController.text
                                + priceController.text);

                            final newMenuOrder = MenuOrder(
                                menuOrderId: "",
                                menuOrderType: typeController.text,
                                menuOrderDuration: durationController.text,
                                menuOrderPrice: int.parse(priceController.text));
                            newMenuOrder.insert.then((value) {
                              print("Add snackbar/notif success: $value");
                              // ignore: deprecated_member_use
                              var snackBar =
                                  SnackBar(content: Text('Yay! It Success.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setEmpty();
                            }).catchError((error) {
                              //snackbar fail
                              print("Add snackbar/notif fail: $error");
                              // ignore: deprecated_member_use
                              var snackBar = SnackBar(
                                  content:
                                      Text('Oh sorry. It fail, try again !'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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

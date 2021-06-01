import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/adminUI/admin_navigation_view.dart';
import 'package:shoes_care/adminUI/detail_order.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/courier.dart';
import 'package:shoes_care/model/order.dart';


class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  final List courierList;
  const EntryItem(this.entry, this.courierList);

  Widget _buildTiles(context, Order root) {
    TextEditingController paymentIdController = TextEditingController();
    paymentIdController.text = 'Cash';

    TextEditingController courierIdController = TextEditingController();


    Widget subtitleByOrder() {
      if(root.getOrderStatus == "New Order" && root.getCourierId == "") {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Accept"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child:Text("Are you sure you want to accept the order?",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            )),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                          child: new Row(
                                            children: <Widget>[
                                              new Expanded(
                                                  child: new TextField(
                                                    controller: courierIdController,
                                                    readOnly: true,
                                                    style: TextStyle(fontSize: 16),
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: "Courier",
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      prefixIcon: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.only(start: 12.0),
                                                        child: Icon(Icons
                                                            .sports_motorsports), // myIcon is a 48px-wide widget.
                                                      ),
                                                      suffixIcon: PopupMenuButton<dynamic>(
                                                        icon: const Icon(Icons.arrow_drop_down),
                                                        onSelected: (dynamic value) {
                                                          courierIdController.text = value;
                                                        },
                                                        itemBuilder: (BuildContext context) {
                                                          return courierList.map<PopupMenuItem<dynamic>>((dynamic item) {
                                                            var value = Courier.fromSnapshot(item);
                                                            return new PopupMenuItem(
                                                                child: new Text(value.getCourierName)
                                                                , value: value.getEmail);
                                                          }).toList();
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: courierIdController.text,
                                                  customerId: root.getCustomerId,
                                                  menuOrderType: root.getMenuOrderType,
                                                  orderAddress: root.getOrderAddress,
                                                  orderDateTime: root.getOrderDateTime,
                                                  orderPickupTime: root.getOrderPickupTime,
                                                  orderStatus: 'New Order',
                                                  paymentId: root.getPaymentId,);
                                              currentOrder.update;
                                              courierIdController.clear();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminHome(index:0)),
                                              );
                                              courierIdController.clear();
                                              var snackBar =
                                              SnackBar(content: Text('Yay! It Success.'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        );
      }
      else if(root.getOrderStatus == "New Order" && root.getCourierId != "") {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Pick up"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child:Text("Are you sure you want to change the status into Pick up?",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                orderId: root.getOrderId,
                                                adminId: root.getAdminId,
                                                courierId: root.getCourierId,
                                                customerId: root.getCustomerId,
                                                menuOrderType: root.getMenuOrderType,
                                                orderAddress: root.getOrderAddress,
                                                orderDateTime: root.getOrderDateTime,
                                                orderPickupTime: root.getOrderPickupTime,
                                                orderStatus: 'Pick up',
                                                paymentId: root.getPaymentId,);
                                              currentOrder.update;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminHome(index:0)),
                                              );
                                              courierIdController.clear();
                                              var snackBar =
                                              SnackBar(content: Text('Yay! It Success.'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Pick up",
                                              style: TextStyle(color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        );
      }

      else if(root.getOrderStatus == "Pick up") {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Progress"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Center(
                                            child: Text(
                                              "Are you sure you want to change the status into Progress?",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: root.getCourierId,
                                                  customerId: root
                                                      .getCustomerId,
                                                  menuOrderType: root
                                                      .getMenuOrderType,
                                                  orderAddress: root
                                                      .getOrderAddress,
                                                  orderDateTime: root
                                                      .getOrderDateTime,
                                                  orderPickupTime: root
                                                      .getOrderPickupTime,
                                                  orderStatus: 'Progress',
                                                  paymentId: root.getPaymentId,);
                                              currentOrder.update;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminHome(index:1)),
                                              );
                                              var snackBar =
                                              SnackBar(content: Text(
                                                  'Yay! It Success.'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        );
      }
      else if(root.getOrderStatus == "Progress") {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Deliver"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Center(
                                            child: Text(
                                              "Are you sure you want to change the status into Deliver?",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: root.getCourierId,
                                                  customerId: root
                                                      .getCustomerId,
                                                  menuOrderType: root
                                                      .getMenuOrderType,
                                                  orderAddress: root
                                                      .getOrderAddress,
                                                  orderDateTime: root
                                                      .getOrderDateTime,
                                                  orderPickupTime: root
                                                      .getOrderPickupTime,
                                                  orderStatus: 'Deliver',
                                                  paymentId: root.getPaymentId,);
                                              currentOrder.update;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminHome(index:2)),
                                              );
                                              var snackBar =
                                              SnackBar(content: Text(
                                                  'Yay! It Success.'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        );
      }
      else if(root.getOrderStatus == "Deliver") {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Complete"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child:Text("Are you sure you want to change the status into Complete?",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            )),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                          child: new Row(
                                            children: <Widget>[
                                              new Expanded(
                                                  child: new TextField(
                                                    controller: paymentIdController,
                                                    readOnly: true,
                                                    style: TextStyle(fontSize: 16),
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: "Payment Type",
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          borderSide: BorderSide(color: Colors.grey)),
                                                      prefixIcon: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.only(start: 12.0),
                                                        child: Icon(Icons
                                                            .payment), // myIcon is a 48px-wide widget.
                                                      ),
                                                      suffixIcon: PopupMenuButton<String>(
                                                        icon: const Icon(Icons.arrow_drop_down),
                                                        onSelected: (String value) {
                                                          paymentIdController.text = value;
                                                        },
                                                        itemBuilder: (BuildContext context) {
                                                          return <String>['Cash', 'Gopay', 'OVO', 'DANA']
                                                              .map<PopupMenuItem<String>>((String value) {
                                                            return new PopupMenuItem(
                                                                child: new Text(value), value: value);
                                                          }).toList();
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              final currentOrder = Order(
                                                  orderId: root.getOrderId,
                                                  adminId: root.getAdminId,
                                                  courierId: root.getCourierId,
                                                  customerId: root.getCustomerId,
                                                  menuOrderType: root.getMenuOrderType,
                                                  orderAddress: root.getOrderAddress,
                                                  orderDateTime: root.getOrderDateTime,
                                                  orderPickupTime: root.getOrderPickupTime,
                                                  orderStatus: 'Complete',
                                                  paymentId: paymentIdController.text);
                                              currentOrder.update;
                                              paymentIdController.text = 'Cash'; //default to cash
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminHome(index:3)),
                                              );
                                              var snackBar =
                                              SnackBar(content: Text('Yay! It Success.'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              "Update",
                                              style: TextStyle(color: AppTheme.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.maroon,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(color: AppTheme.maroon),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.white,
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ))

          ],
        );
      }
      else {
        return Column(
          children: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Edit"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailOrderView(order: root)),
                        );
                      },
                    ),
                  ],
                ))

          ],
        );
      }
    }
    
     String titleOrder = '#'+root.getOrderId + ' - ' + root.getMenuOrderType + ' - ' + DateFormat('dd/MM/yyyy')
         .format(root.orderDateTime)
         .toString();
     String textOrder = "";
     if(root.getOrderStatus == "Pick up"){
       textOrder += "Pick up at "+root.getOrderPickupTime + " by "+root.getCourierId+ "\n";
     } else if(root.getOrderStatus == "Complete"){
       textOrder += "Paid by "+root.getPaymentId+ "\n";
     }
     textOrder += root.getCustomerId + '\n' + root.getOrderAddress;

      return ExpansionTile(
        title: Text(titleOrder),
          children: <Widget>[
              ListTile(
                title: Text(textOrder),
                subtitle: subtitleByOrder(),
              )
          ],

      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(context, entry);
  }

  
}


Widget buildOrderCard(BuildContext context, DocumentSnapshot document, List courierList) {
  final Order order = Order.fromSnapshot(document);
  return EntryItem(order, courierList);
}

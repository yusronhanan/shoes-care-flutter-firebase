import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/courierUI/courier_navigation_view.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/model/order.dart';
import 'package:shoes_care/model/customer.dart';
import 'package:shoes_care/model/payment.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');


Future<List> _fetchUserData(customerEmail) async {
  String customerName = customerEmail;
  String customerPhone = "";

  // here you write the codes to input the data into firestore
  Customer customerData = Customer(
      customerId: "",
      customerName: "",
      email: customerEmail,
      password: "",
      customerPhone: "",
      customerAddress: "");
  await customerData.syncDataByEmail(customerEmail);
  customerName = customerData.getCustomerName;
  customerPhone = customerData.getCustomerPhone;
  return [customerName, customerPhone];
}

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  final MenuOrder menuOrder;
  final List paymentList;
  const EntryItem(this.entry, this.menuOrder, this.paymentList);

  _buildTiles(context, Order root, customerData) {
      TextEditingController paymentIdController = TextEditingController();
      var defaultPayment = Payment.fromSnapshot(paymentList[0]).getPaymentName;
      paymentIdController.text = defaultPayment;
      if(customerData[0] == ""){
        customerData[0] = root.getCustomerId;
      }
      String textOrder = '';


        textOrder+='#'+root.orderId + ' \n';

        textOrder+=root.getOrderStatus +' on '+  DateFormat('dd/MM/yyyy')
        .format(root.getOrderDateTime).toString() +' around '+ root.getOrderPickupTime +' \n'
        +customerData[0] +' - '+customerData[1] + '\n';

      var orderDate = root.orderDateTime;
      if(menuOrder != null){
        var estimatedDoneDate = orderDate.add(Duration(days: menuOrder.getMenuOrderDuration));
          textOrder += 'Estimated done: ' + DateFormat('dd/MM/yyyy')
              .format(estimatedDoneDate)
              .toString() + '\n';
        textOrder+= menuOrder.getMenuOrderType + ' - '
            + formatCurrency.format(menuOrder.getMenuOrderPrice)+'\n';
      }
        textOrder+=root.getOrderAddress;

      return ListTile(
        title: Text(textOrder),
        subtitle: Column(
          children: <Widget>[
            Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text("Done"),
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
                                                      suffixIcon: PopupMenuButton<dynamic>(
                                                        icon: const Icon(Icons.arrow_drop_down),
                                                        onSelected: (dynamic value) {
                                                          paymentIdController.text = value;
                                                        },
                                                        itemBuilder: (BuildContext context) {
                                                          return paymentList.map<PopupMenuItem<dynamic>>((dynamic item) {
                                                            var value = Payment.fromSnapshot(item);
                                                            return new PopupMenuItem(
                                                                child: new Text(value.getPaymentName)
                                                                , value: value.getPaymentName);
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
                                              paymentIdController.text = defaultPayment; //default to cash
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CourierHome(index: 0)));
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
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // return  _buildTiles(entry);
    return FutureBuilder(
      future: _fetchUserData(entry.getCustomerId),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          print("customerData" + snapshot.data.toString());
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _buildTiles(context, entry, ["",""]);
            break;
            case ConnectionState.done:
              return _buildTiles(context, entry, snapshot.data);
              break;
            default:
              return _buildTiles(context, entry, snapshot.data);
          }
        } else{
          return _buildTiles(context, entry, ["",""]);
        }

      },
    );
  }
}


Widget buildDeliverOrderCard(BuildContext context, DocumentSnapshot document, List menuOrderList, List paymentList) {
  final Order order = Order.fromSnapshot(document);
  MenuOrder menuOrder = MenuOrder.fromSnapshot(menuOrderList[0]); //default = 0 if null

  for (var mo in menuOrderList) {
    var m = MenuOrder.fromSnapshot(mo);
    if(m.getMenuOrderType == order.getMenuOrderType){
      menuOrder = m;
    }
  }

  return EntryItem(order, menuOrder, paymentList);
}

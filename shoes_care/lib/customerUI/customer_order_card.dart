import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/model/menu_order.dart';
import 'package:shoes_care/model/order.dart';


final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class EntryItem extends StatelessWidget {
  // final Entry entry;
  final Order entry;
  final MenuOrder menuOrder;
  const EntryItem(this.entry, this.menuOrder);

  Widget _buildTiles(Order root) {

    String textOrder = '#'+root.orderId;
    if(root.orderStatus != 'Complete'){
      if(root.orderStatus == 'Pick up'){
        textOrder += ' - Pick up at '+ root.getOrderPickupTime;
      } else{
        textOrder += ' - ' + root.orderStatus;
      }
    }
    var orderDate = root.orderDateTime;
    textOrder +=  '\nOrder date: '+DateFormat('dd/MM/yyyy')
        .format(orderDate)
        .toString() + '\n';
    if(menuOrder != null){
      var estimatedDoneDate = orderDate.add(Duration(days: menuOrder.getMenuOrderDuration));
      if(root.getOrderStatus != 'Complete') {
        textOrder += 'Estimated done: ' + DateFormat('dd/MM/yyyy')
            .format(estimatedDoneDate)
            .toString() + '\n';
      }
      textOrder+= menuOrder.getMenuOrderType + ' - '
                + formatCurrency.format(menuOrder.getMenuOrderPrice);
    }

    if(root.orderStatus == 'Complete'){
      textOrder += '\nPaid by '+root.getPaymentId;
    }

      return ListTile(
        title: Text(textOrder),
      );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}


Widget buildOrderCard(BuildContext context, DocumentSnapshot document, List menuOrderList) {
  final Order order = Order.fromSnapshot(document);
  MenuOrder menuOrder = MenuOrder.fromSnapshot(menuOrderList[0]); //default = 0 if null
  for (var mo in menuOrderList) {
    var m = MenuOrder.fromSnapshot(mo);
    if(m.getMenuOrderType == order.getMenuOrderType){
      menuOrder = m;
    }
  }
    return EntryItem(order, menuOrder);
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_care/app_theme.dart';

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

class CustomerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomerHomePageState();
  }
}

class CustomerHomePageState extends State<CustomerHomePage> {

  // final TextEditingController adminIdController = TextEditingController();
  // final TextEditingController courierIdController = TextEditingController();
  // final TextEditingController customerIdController = TextEditingController();
  final TextEditingController menuOrderTypeController = TextEditingController();
  final TextEditingController orderAddressController = TextEditingController();
  final TextEditingController orderPickupTimeController = TextEditingController();

  // final TextEditingController orderStatusController = TextEditingController();
  final TextEditingController orderDateTimeController = TextEditingController();
  DateTime orderDateTimeValue = DateTime.now();
  //TODO change it in edit form, refer to firestore value
  // String paymentIdController = 'Cash'; //INITIAL DEFAULT
  // final TextEditingController paymentIdController = TextEditingController();

  setEmpty() {
    // adminIdController.clear();
    // courierIdController.clear();
    // customerIdController.clear();
    menuOrderTypeController.clear();
    orderAddressController.clear();
    orderDateTimeController.clear();
    orderPickupTimeController.clear();
    // orderStatusController.clear();
    // paymentIdController.clear();
    // paymentIdController = 'Cash';
    orderDateTimeValue = DateTime.now();
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 6));

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: _endDate,
    );

    if (picked != null)
      setState(() => {
        orderDateTimeController.text =
            DateFormat('dd/MM/yyyy').format(picked).toString(),
        orderDateTimeValue = picked
      });
  }


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
                      margin: EdgeInsets.only(bottom: 18),
                      child: Text(
                        'The best treatment for your shoes                ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 10),
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
                    Padding(

                      padding:
                      EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new TextField(
                                controller: menuOrderTypeController,
                                readOnly: true,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Menu Order Type',
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
                                        .water_damage), // myIcon is a 48px-wide widget.
                                  ),
                                  suffixIcon: PopupMenuButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onSelected: (String value) {
                                      menuOrderTypeController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <String>[
                                        'Fast Cleaning',
                                        'Deep Cleaning',
                                        'Unyellowing and Whitening',
                                        'Leather Care'
                                      ].map<PopupMenuItem<String>>((String value) {
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
                    Padding(
                      padding:
                      EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),

                      child: InkWell(
                        onTap: () {
                          _selectDate(); // Call Function that has showDatePicker()
                        },
                        child: IgnorePointer(
                          child: TextField(
                            controller: orderDateTimeController,
                            readOnly: true,
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Order Pickup Date",
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
                                    .date_range), // myIcon is a 48px-wide widget.
                              ),
                              suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                                child: Icon(Icons
                                    .arrow_drop_down), // myIcon is a 48px-wide widget.
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),

                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new TextField(
                                controller: orderPickupTimeController,
                                readOnly: true,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Order Pickup Time',
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
                                        .access_time), // myIcon is a 48px-wide widget.
                                  ),
                                  suffixIcon: PopupMenuButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onSelected: (String value) {
                                      orderPickupTimeController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <String>[
                                        '10:00',
                                        '13:00',
                                        '17:00',
                                        '20:00'
                                      ].map<PopupMenuItem<String>>((String value) {
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
                    Padding(
                      padding:
                      EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),

                      child: TextField(
                        controller: orderAddressController,
                        maxLines: 3,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Order Address',
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
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 30),
                          decoration: BoxDecoration(
                              color: AppTheme.maroon, shape: BoxShape.circle),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {

                            },
                            icon: Icon(Icons.add),
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

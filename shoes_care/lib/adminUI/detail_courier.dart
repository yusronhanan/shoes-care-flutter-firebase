import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Courier Details'),
              backgroundColor: Colors.green,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    _courierEditModalBottomSheet(context);
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                courierDetails(),
                totalBudgetCard(),
                daysOutCard(),
                notesCard(context),
                Container(
                  height: 200,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget daysOutCard() {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("AA", style: TextStyle(fontSize: 75)),
            Text("days until your courier", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }

  Widget courierDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.courier.courierName,
                  style: TextStyle(fontSize: 30, color: Colors.green[900]),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text("${widget.courier.getCourierAddress}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalBudgetCard() {
    return Card(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Daily Budget",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Flexible(
                //   child: AutoSizeText(
                //     "\$$_budget",
                //     style: TextStyle(fontSize: 100),
                //     maxLines: 1,
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text(
                      "\$${widget.courier.getCourierPhone} total",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget notesCard(context) {
    return Hero(
      tag: "CourierNotes-${widget.courier.getCourierId}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.deepPurpleAccent,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Courier Notes",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: setNoteText(),
                ),
              )
            ],
          ),
          onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               EditNotesView(courier: widget.courier)));
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (widget.courier.courierAddress == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [
        Text(widget.courier.getCourierAddress,
            style: TextStyle(color: Colors.grey[300]))
      ];
    }
  }

  void _courierEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Edit Courier"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.courier.courierName,
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deleteCourier(context);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
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

  Future updateCourier(context) async {
    final doc = FirebaseFirestore.instance
        .collection('courier')
        .doc(widget.courier.courierId);

    return await doc.update(widget.courier.toJson());
  }

  Future deleteCourier(context) async {
    final doc = FirebaseFirestore.instance
        .collection('userData')
        .doc(widget.courier.courierId);

    return await doc.delete();
  }
}

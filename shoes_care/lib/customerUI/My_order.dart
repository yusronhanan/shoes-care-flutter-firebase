import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Order',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageOrder(),
              flex: 7,
            ),
          ],
        ),
      ),
    );
  }
}

class PageOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int idx) => EntryItem(data[idx]),
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

//isi list
final List<Entry> data = <Entry>[
  Entry('In Process', <Entry>[
    Entry('#202004182 - Yellowing 3 Days', <Entry>[Entry('Testt')]),
    Entry('#202004183 - Regular 1 Days', <Entry>[Entry('Testt')]),
    Entry('#202004184 - Regular 2 Days', <Entry>[Entry('Testt')])
  ]),
  Entry('Completed', <Entry>[
    Entry('#202003171 - Repair 5 Days', <Entry>[Entry('Testt')]),
    Entry('#202004162 - Deep Clean 3 Days', <Entry>[Entry('Testt')]),
    Entry('#202004163 - Deep Clean 3 Days', <Entry>[Entry('Testt')])
  ])
];

class EntryItem extends StatelessWidget {
  final Entry entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(entry);
  }
}

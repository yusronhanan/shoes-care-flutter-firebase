import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('supposed to ber login'),
      // ),
      // body: Container(
      //   padding: EdgeInsets.only(top: 215, left: 30),
      //   child: Text.rich(TextSpan(children: <TextSpan>[
      //     TextSpan(
      //         text: 'Shoes',
      //         style: TextStyle(
      //             fontSize: 25,
      //             fontStyle: FontStyle.italic,
      //             fontWeight: FontWeight.w700)),
      //     TextSpan(
      //         text: ' &',
      //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
      //     TextSpan(
      //         text: 'Care',
      //         style: TextStyle(
      //             fontSize: 25,
      //             fontStyle: FontStyle.italic,
      //             fontWeight: FontWeight.w700)),
      //   ])),
      // ),
      body: Container(
          margin: EdgeInsets.only(top: 215, left: 30),
          height: 100,
          width: 200,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 2.0),
          // ),
          child: Image.network(
              'https://i.pinimg.com/originals/58/1d/47/581d477ba2f9ef3126c961fc7e47a350.png')),

      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 600.0),
        child: FloatingActionButton(
          child: Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 25.0,
          ),
          backgroundColor: Colors.white,
          onPressed: () {},
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(17))),
        ),
      ),
    );
  }
}

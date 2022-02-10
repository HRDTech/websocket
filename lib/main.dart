import 'package:flutter/material.dart';
import 'package:websocket/pages/websocket1.dart';
import 'package:websocket/pages/websocket2.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        'Eje1' : (BuildContext context) => SocketDemo(),
        'Eje2' : (BuildContext context) => WebSoketEje2(),
      },
      initialRoute: 'Eje2',
    );
  }
}


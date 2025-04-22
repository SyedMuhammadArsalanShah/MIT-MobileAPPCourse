import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
             height: 100,
             width: 300,
            color: Colors.teal,
            child: Center(child: Text("SAAD SALEEM", style: TextStyle(fontSize: 20, color: Colors.white),))),
        ),
      ),
    );
  }
}

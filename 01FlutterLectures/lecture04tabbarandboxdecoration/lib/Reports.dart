import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 300,
        height: 300, 
        // color:  Colors.teal,
        decoration: BoxDecoration(
          // color:Colors.red
         gradient: LinearGradient(
          colors: [Color(0xff2bc0e4), Color(0xffeaecc6)],
          stops: [0, 1],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )
      ,
      // borderRadius: BorderRadius.circular(21),
      // borderRadius: BorderRadius.only(

      //   topLeft: Radius.circular(21),
      //   bottomRight: Radius.circular(21),
      // ),
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: Colors.green , blurRadius: 10,spreadRadius: 15 )],
        border: Border.all(
          width: 2,
          
          color: Colors.black)
        ),
        
      ),
    ));
  }
}

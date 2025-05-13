import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Signup(),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> apicallkarden() async {
    final url = Uri.parse("http://192.168.0.162/mit_api_flutter/index.php");

    var response = await http.post(url, body: {
      'name': name.text,
      'email': email.text,
      'password': password.text,
    });

    var data = jsonDecode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["message"])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: name,
          ),
          TextField(
            controller: email,
          ),
          TextField(
            controller: password,
          ),
          ElevatedButton(onPressed: apicallkarden, child: Text("Submit"))
        ],
      ),
    );
  }
}

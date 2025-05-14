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
      home: const SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  apiCallKaren() async {
    http.Response response = await http
        .post(Uri.parse("http://192.168.230.152/cisd_api/formReg.php"), body: {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    var data = jsonDecode(response.body);

    print(data["message"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: passwordController,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: apiCallKaren, child: Text("Submit"))
        ],
      ),
    );
  }
}

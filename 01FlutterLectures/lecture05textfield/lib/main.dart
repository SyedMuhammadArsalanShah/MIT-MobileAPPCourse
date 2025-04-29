import 'package:flutter/material.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.indigo[900],
            height: 300,
            child: Center(
                child: Text(
              "Login Form",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              enabled: true,
              decoration: InputDecoration(
                  hintText: "demo@gmail.com",
                  label: Text("Enter Your Email"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(color: Colors.teal, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(color: Colors.indigo, width: 1),
                  ),
                  prefixIcon: Icon(Icons.email_rounded),
                  suffix: IconButton(
                      onPressed: () {
                        print("This is my login info");
                      },
                      icon: Icon(Icons.info))),
              keyboardType: TextInputType.emailAddress,
              controller: email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: pass,
                            enabled: true,
                decoration: InputDecoration(
                    // hintText: "demo@gmail.com",
                    // label: Text("Enter Your Email"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: Colors.teal, width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: Colors.indigo, width: 1),
                    ),
                    prefixIcon: Icon(Icons.remove_red_eye),
                    suffix: IconButton(
                        onPressed: () {
                          print("This is my login info");
                        },
                        icon: Icon(Icons.info))),
                keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: "#",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                String emailValue = email.text.toString();
                String passValue = pass.text.toString();

                print("EmailAddress" + emailValue);
                print("Password " + passValue);
              },
              child: Text("Login Form "))
        ],
      ),
    );
  }
}

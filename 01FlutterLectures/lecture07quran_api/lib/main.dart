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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SurahIndexSCR(),
    );
  }
}

class SurahIndexSCR extends StatefulWidget {
  const SurahIndexSCR({super.key});

  @override
  State<SurahIndexSCR> createState() => _SurahIndexSCRState();
}

class _SurahIndexSCRState extends State<SurahIndexSCR> {
  Map mapresp = {};
  List list = [];

  Future apicallkardo() async {
    http.Response response =
        await http.get(Uri.parse("https://api.alquran.cloud/v1/surah"));

    if (response.statusCode == 200) {
      setState(() {
        mapresp = jsonDecode(response.body);
        list = mapresp["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apicallkardo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(list[index]["number"].toString()),
            ),
            title: Text(list[index]["name"]),
            subtitle: Text(list[index]["englishName"]),
            trailing: Text(list[index]["numberOfAyahs"].toString()),
          );
        },
      ),
    );
  }
}

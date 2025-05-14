import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: const Dua(),
    );
  }
}

class Dua extends StatefulWidget {
  const Dua({super.key});

  @override
  State<Dua> createState() => _DuaState();
}

class _DuaState extends State<Dua> {
  Map resp = {};
  List respList = [];

  loadData() async {
    var response = await rootBundle.loadString("assets/duas/chapters.json");
    setState(() {
      respList = jsonDecode(response);

      // respList = resp["data"]["ayahs"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: respList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailDua(respList[index]["chapter_number"]),
                  ));
            },
            title: Text(respList[index]["arabic_name"]),
          );
        },
      ),
    );
  }
}

class DetailDua extends StatefulWidget {
  var duaNum;
  DetailDua(this.duaNum, {super.key});

  @override
  State<DetailDua> createState() => _DetailDuaState();
}

class _DetailDuaState extends State<DetailDua> {
  Map resp = {};
  List respList = [];

  loadData() async {
    var response =
        await rootBundle.loadString("assets/duas/hisn_ul_muslim.json");
    setState(() {
      resp = jsonDecode(response);

      //  "1"=> "(1)"
      String number = "(" + widget.duaNum + ")";
      respList = resp[number]["hadiths"];

      // respList = resp["data"]["ayahs"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: respList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              width: double.infinity,
              color: Color(0xffEEEEEB),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(respList[index]["arabic_hadith"])),
              ),
            ),
          );
        },
      ),
    );
  }
}

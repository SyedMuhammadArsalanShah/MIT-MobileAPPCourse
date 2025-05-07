import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Map map = {};
  List list = [];

  Future apicallkardo() async {
    http.Response response =
        await http.get(Uri.parse("https://api.alquran.cloud/v1/surah"));

    if (response.statusCode == 200) {
      setState(() {
        map = jsonDecode(response.body);
        list = map["data"];
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
          var surah = list[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSurah(surah["number"]),
                  ));
            },
            leading: CircleAvatar(
              child: Text(surah["number"].toString()),
            ),
            title: Text(surah["name"] + " | " + surah["englishName"]),
            subtitle: Text(surah["englishNameTranslation"]),
            trailing: Text("Verses \n ${surah["numberOfAyahs"]}"),
          );
        },
      ),
    );
  }
}

class DetailSurah extends StatefulWidget {
  var surahNum;
  DetailSurah(this.surahNum, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  Map map = {};
  List list = [];

  Map umap = {};
  List ulist = [];
  Future apicallkardo() async {
    http.Response response = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/surah/${widget.surahNum}"));

    if (response.statusCode == 200) {
      setState(() {
        map = jsonDecode(response.body);
        list = map["data"]["ayahs"];
      });
    }
  }

  Future translation() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.alquran.cloud/v1/surah/${widget.surahNum}/ur.maududi"));

    if (response.statusCode == 200) {
      setState(() {
        umap = jsonDecode(response.body);
        ulist = umap["data"]["ayahs"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicallkardo();
    translation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var surah = list[index];
                return ListTile(
                  title: Text(
                    surah["text"],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.amiri(),
                  ),
                  subtitle: Text(
                    ulist[index]["text"],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

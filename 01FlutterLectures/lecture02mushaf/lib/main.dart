import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lecture02mushaf/AudioIndexSurah.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashSCR(),
    );
  }
}

class SplashSCR extends StatefulWidget {
  const SplashSCR({super.key});

  @override
  State<SplashSCR> createState() => _SplashSCRState();
}

class _SplashSCRState extends State<SplashSCR> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ButtonScreen(),
            ));
      },
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/quran.png")),
    );
  }
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => Audioindexsurah(),));
            }, child: Text("Recitation | Mushaf")),
            ElevatedButton(onPressed: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => SurahIndexSCR() ,));
            }, child: Text("Read  | Mushaf")),
          ],
        ),
      ),
    );
  }
}








class SurahIndexSCR extends StatefulWidget {
  const SurahIndexSCR({super.key});

  @override
  State<SurahIndexSCR> createState() => _SurahIndexSCRState();
}

class _SurahIndexSCRState extends State<SurahIndexSCR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: quran.totalMadaniSurahs,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSurah(index + 1),
                  ));
            },
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(
              quran.getSurahNameArabic(index + 1),
              style: GoogleFonts.amiriQuran(),
            ),
            subtitle: Text(
              quran.getSurahNameEnglish(index + 1),
              style: GoogleFonts.amiriQuran(),
            ),
            trailing: Column(
              children: [
                quran.getPlaceOfRevelation(index + 1) == "Makkah"
                    ? Image.asset(
                        "assets/images/kaaba.png",
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        "assets/images/madina.png",
                        width: 30,
                        height: 30,
                      ),
                Text("Verses" + quran.getVerseCount(index + 1).toString())
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailSurah extends StatefulWidget {
  var surahNumber;
  DetailSurah(this.surahNumber, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahName(widget.surahNumber)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(widget.surahNumber),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  quran.getVerse(widget.surahNumber, index + 1,
                      verseEndSymbol: true),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.amiriQuran(),
                ),
                subtitle: Text(
                  quran.getVerseTranslation(
                    widget.surahNumber,
                    translation: quran.Translation.urdu,
                    index + 1,
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: "jameel"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lecture02mushaf/DetailAudioSurah.dart';
import 'package:lecture02mushaf/main.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
class Audioindexsurah extends StatefulWidget {
  const Audioindexsurah({super.key});

  @override
  State<Audioindexsurah> createState() => _AudioindexsurahState();
}

class _AudioindexsurahState extends State<Audioindexsurah> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: quran.totalMadaniSurahs,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailaudiosurah(index + 1),
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
            "شیخ مشاری راشد العفاسی",
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

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class Detailaudiosurah extends StatefulWidget {
  var indexSurahNumber;
  Detailaudiosurah(this.indexSurahNumber, {super.key});

  @override
  State<Detailaudiosurah> createState() => _DetailaudiosurahState();
}

class _DetailaudiosurahState extends State<Detailaudiosurah> {
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playpausebtn = Icons.play_arrow_rounded;
  bool isplaying = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    audioPlayer.dispose();
  }

  Future<void> meratoggleBtn() async {
    try {
      final audiourl = await quran.getAudioURLBySurah(widget.indexSurahNumber);

      audioPlayer.setUrl(audiourl);

      if (isplaying) {
        audioPlayer.play();

        setState(() {
          isplaying = false;
          playpausebtn = Icons.pause_circle_rounded;
        });
      } else {
        audioPlayer.pause();

        setState(() {
          isplaying = true;
          playpausebtn = Icons.play_arrow_rounded;
        });
      }
    } catch (e) {
      print("There is an issue $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(quran.getSurahNameArabic(widget.indexSurahNumber)),
            CircleAvatar(
              backgroundColor: Colors.teal[900],
              radius: 150,
              child: Image.asset("assets/images/alaffasy.png",),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.teal[900],
              width: 100,
              height: 50,
              child: Center(
                child: IconButton(
                  onPressed: meratoggleBtn,
                  icon: Icon(playpausebtn, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

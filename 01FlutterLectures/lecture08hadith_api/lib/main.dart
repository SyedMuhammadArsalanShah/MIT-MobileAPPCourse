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
        home: BooksSCR());
  }
}

class BooksSCR extends StatefulWidget {
  const BooksSCR({super.key});

  @override
  State<BooksSCR> createState() => _BooksSCRState();
}

class _BooksSCRState extends State<BooksSCR> {
  Map mapBooks = {};
  List listBooks = [];

  Future apiCallKaren() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/api/books?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      setState(() {
        mapBooks = jsonDecode(response.body);
        listBooks = mapBooks["books"];
      });
    } else {
      print("error exist");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallKaren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: listBooks.length,
      itemBuilder: (context, index) {
        var hbooks = listBooks[index];

        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterSCR(
                          (hbooks["bookSlug"]),
                        )));
          },
          leading: CircleAvatar(child: Text("${index + 1}")),
          title: Text(hbooks["bookName"]),
          subtitle: Text(hbooks["writerName"]),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Chapters" + hbooks["chapters_count"]),
              Text("Hadiths" + hbooks["hadiths_count"]),
            ],
          ),
        );
      },
    ));
  }
}

// ignore: must_be_immutable
class ChapterSCR extends StatefulWidget {
  var bookSlug;

  ChapterSCR(this.bookSlug, {super.key});

  @override
  State<ChapterSCR> createState() => _ChapterSCRState();
}

class _ChapterSCRState extends State<ChapterSCR> {
  Map mapBooks = {};
  List listBooks = [];

  Future apiCallKaren() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/api/${widget.bookSlug}/chapters?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      setState(() {
        mapBooks = jsonDecode(response.body);
        listBooks = mapBooks["chapters"];
      });
    } else {
      print("error exist");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallKaren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: listBooks.length,
      itemBuilder: (context, index) {
        var hbooks = listBooks[index];

        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HadithsSCR(hbooks["bookSlug"], hbooks["chapterNumber"]),
                ));
          },
          leading: CircleAvatar(child: Text(hbooks["chapterNumber"])),
          title: Text(hbooks["chapterArabic"]),
          subtitle: Text(hbooks["chapterUrdu"]),
        );
      },
    ));
  }
}

// ignore: must_be_immutable
class HadithsSCR extends StatefulWidget {
  var booksSlug;
  var chapterNumber;
  HadithsSCR(this.booksSlug, this.chapterNumber, {super.key});

  @override
  State<HadithsSCR> createState() => _HadithsSCRState();
}

class _HadithsSCRState extends State<HadithsSCR> {
  Map mapBooks = {};
  List listBooks = [];

  Future apiCallKaren() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e&book=${widget.booksSlug}&chapter=${widget.chapterNumber}&paginate=100000"));

    if (response.statusCode == 200) {
      setState(() {
        mapBooks = jsonDecode(response.body);
        listBooks = mapBooks["hadiths"]["data"];
      });
    } else {
      print("error exist");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallKaren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: listBooks.length,
      itemBuilder: (context, index) {
        var hbooks = listBooks[index];

        return ListTile(
          leading: CircleAvatar(child: Text(hbooks["hadithNumber"])),
          title: Text(hbooks["hadithArabic"]),
          subtitle: Text(hbooks["hadithUrdu"]),
        );
      },
    ));
  }
}

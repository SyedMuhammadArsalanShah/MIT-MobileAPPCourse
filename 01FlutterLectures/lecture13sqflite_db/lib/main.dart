import 'package:flutter/material.dart';
import 'package:lecture13sqflite_db/services/Db_helper.dart';

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
      ),
      home: const MyHome(),
    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController achybachy = TextEditingController();

  List<Map<String, dynamic>> data = [];
  alldata() async {
    List<Map<String, dynamic>> datalist =
        await Db_helper.instance.querydatabase();
    setState(() {
    data = datalist;      
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    alldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          achybachy.clear();
          meraWidget(0);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]["name"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      achybachy.text = data[index]["name"];
                      meraWidget(data[index]["id"]);
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      Db_helper.instance.deleteRecord(data[index]["id"]);
                      alldata();
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
    );
  }

  void meraWidget(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: id == 0 ? Text("Add Record") : Text("Update Record"),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: achybachy,
              decoration: InputDecoration(hintText: "Enter Your Name "),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (id == 0) {
                    String name = achybachy.text.toString();
                    Db_helper.instance.insertRecord({Db_helper.dt_name: name});
                  } else {
                    String name = achybachy.text.toString();
                    Db_helper.instance.updateRecord(
                        {Db_helper.dt_name: name, Db_helper.dt_id: id});
                  }
                alldata();
                  achybachy.clear();
                  Navigator.of(context).pop();
                },
                child: id == 0 ? Text("Add") : Text("Update"))
          ],
        );
      },
    );
  }
}
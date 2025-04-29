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
      debugShowCheckedModeBanner: false,
      title: 'Flutter TODO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeTodoApp(),
    );
  }
}

class HomeTodoApp extends StatefulWidget {
  const HomeTodoApp({super.key});

  @override
  State<HomeTodoApp> createState() => _HomeTodoAppState();
}

class _HomeTodoAppState extends State<HomeTodoApp> {
  var todos = ["ABC", "XYZ", "PAK"];
  var output = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoApp"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(todos[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onDoubleTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Enter Your Task "),
                            content: TextField(
                              onChanged: (value) {
                                output = value;
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      todos.replaceRange(
                                          index, index + 1, {output});
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Update"))
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.edit)),
                InkWell(
                    onTap: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                    child: Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter Your Task "),
                content: TextField(
                  onChanged: (value) {
                    output = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todos.add(output);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"))
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

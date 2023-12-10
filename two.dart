import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<List<Data>> fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/2/comments');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occur!');
  }
}

class Data {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Data({required this.postId, required this.id, required this.name, required this.email, required this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comments List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: const Main());
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          const SizedBox(height: 100.0,);
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(child:Text(snapshot.data![index].postId.toString())),
                      Expanded(child:Text(snapshot.data![index].id.toString())),
                      Expanded(child:Text(snapshot.data![index].name)),
                      Expanded(child:Text(snapshot.data![index].email)),
                      Expanded(child:Text(snapshot.data![index].body))
                    ],
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

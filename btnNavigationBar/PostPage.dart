import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users/1/posts');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occur!');
  }
}

class Data {
  final int userId;
  final int id;
  final String title;
  final String body;

  Data({required this.userId, required this.id, required this.title, required this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: const PostP());
  }
}

class PostP extends StatefulWidget {
  const PostP({super.key});

  @override
  State<PostP> createState() => _PostPState();
}

class _PostPState extends State<PostP> {
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
                      Expanded(child:Text(snapshot.data![index].userId.toString())),
                      Expanded(child:Text(snapshot.data![index].id.toString())),
                      Expanded(child:Text(snapshot.data![index].title)),
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

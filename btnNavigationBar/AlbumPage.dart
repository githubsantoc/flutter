import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users/1/albums');
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

  Data({required this.userId, required this.id, required this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Albums'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: const AlbumP());
  }
}

class AlbumP extends StatefulWidget {
  const AlbumP({super.key});

  @override
  State<AlbumP> createState() => _AlbumPState();
}

class _AlbumPState extends State<AlbumP> {
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
                return ListTile(
                  title:Text('userId:'+(snapshot.data![index].userId).toString()+'    Id:'+(snapshot.data![index].id).toString(),textAlign: TextAlign.left,
                      style:const TextStyle(backgroundColor: Colors.grey)),
                  subtitle:Text('Title:'+(snapshot.data![index].title),textAlign: TextAlign.left),

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

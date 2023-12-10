import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  var urls = Uri.parse('https://jsonplaceholder.typicode.com/users/1/photos');
  final response = await http.get(urls);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occur!');
  }
}

class Data {
   int albumId;
   int id;
   String title;
   String url;
   String thumbnailUrl;

  Data({required this.albumId, required this.id, required this.title,required this.url, required this.thumbnailUrl});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],

    );
  }
}

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: const PhotoP());
  }
}

class PhotoP extends StatefulWidget {
  const PhotoP({super.key});

  @override
  State<PhotoP> createState() => _PhotoPState();
}

class _PhotoPState extends State<PhotoP> {
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
                  child: Row(
                    children: [
                      Expanded(child:Text(snapshot.data![index].albumId.toString())),
                      Expanded(child:Text(snapshot.data![index].id.toString())),
                      Expanded(child:Text(snapshot.data![index].title)),
                      Expanded(child:Text(snapshot.data![index].url)),
                      Expanded(child:Text(snapshot.data![index].thumbnailUrl))
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

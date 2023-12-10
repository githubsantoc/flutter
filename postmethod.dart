import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Data{
  int postId;
  int id;
  String name;
  String email;
  String body;

  Data({required this.postId,required this.id,required this.name,required this.email,required this.body});
  factory Data.fromJson(Map <String, dynamic> json){
    return Data(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']
    );
  }

}

String result='';
//future function is going to post the data
Future<void> submitData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/2/comments');
  final response = await http.post(url,
      body: {
        'name': 'Santoshi Banjara',
        'email': 'santoshibanj100@gmail.com',
        'body': 'Hello I am doing all this stuffs',
        // Add any other data you want to send in the body
      });


  if (response.statusCode == 201) {
    // Successful POST request, handle the response here
    final responseData = jsonDecode(response.body);
    print(responseData);
    print('Data successfully uploaded');

  } else {
    // If the server returns an error response, throw an exception
    print('Failed to post data');
  }
}
class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text('Post Method'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body:Padding(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              submitData();
            }, child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}


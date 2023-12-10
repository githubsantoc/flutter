import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/2/todos');
  final response = await http.post(url,
      body: {
        'title': 'Add new data',
        'completed': true,

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
Future<Data> updateData(String title ,bool completed) async {
  Map<String, dynamic> request={
    "userId":"1",
    "id":"1",
    "title":title,
    "completed":completed
  };
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos');
  final response = await http.put(url);
  if (response.statusCode == 200) {
    return Data.fromJson(json.decode(response.body));
  } else {
    throw Exception('Unexpected error occur!');
  }
}
Future<List<Data>?> deleteData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return null;
  } else {
    throw Exception('Unexpected error occur!');
  }
}

class Data {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Data({required this.userId, required this.id, required this.title, required this.completed});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: const Todos());
  }
}

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: (){addData();}, child: const Text('Add')),
        const SizedBox(width: 10.0,),
        ElevatedButton(onPressed: () {updateData('Harry', true);}, child: const Text('Updatee')),
        const SizedBox(width: 10.0,),
        ElevatedButton(onPressed: (){deleteData();}, child: const Text('Delete')),
      ],
    );
  }
}

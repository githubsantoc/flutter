import 'package:flutter/material.dart';
import 'package:internship/btnNavigationBar/AlbumPage.dart';
import 'package:internship/btnNavigationBar/PostPage.dart';
import 'package:internship/btnNavigationBar/TodosPage.dart';
import 'package:internship/two.dart';
import 'package:internship/btnNavigationBar/photos.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BtnNaviagation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myIndex=0;
  List pages=const[
    PostPage(),
    AlbumPage(),
    TodosPage(),
    PhotoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigation Bar'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightGreen,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            myIndex=index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Post'),
          BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: 'Albums'),
          BottomNavigationBarItem(
              icon: Icon(Icons.details),
              label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Photos'),
        ],
      ),
    );
  }
}
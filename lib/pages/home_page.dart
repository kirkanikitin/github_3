import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
     appBar: AppBar(
       backgroundColor: Colors.grey[350],
       centerTitle: true,
       title: const Text(
           'Заметки',
         style: TextStyle(
           fontWeight: FontWeight.w300,
         ),
       ),
     ),
    );
  }
}

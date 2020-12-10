import 'package:flutter/material.dart';

/// Date: 2019-09-29 14:44
/// Author: Liusilong
/// Description:
//

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            TextField(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
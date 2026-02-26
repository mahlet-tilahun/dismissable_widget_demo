/*
Dismissible Widget Demo

This demo shows how the dismissible widget can be used 
to remove items by swiping them off the screen in a simple 
To-do list application.

Key properties: key, direction, background

*/

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<String> tasks = [
    'Buy groceries',
    'Reply to emails',
    'Study for quiz',
    'Read 10 pages',
    'Exercise',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(
              task,
            ), // Attribute 1: key: for uniquely identifying each item
            direction: DismissDirection
                .horizontal, // Attribute 2: direction: specifying direction users are allowed to swipe
            background: Container(
              // Attribute 3: background: widget behind the swiped item
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            secondaryBackground: Container(
              // For setting different properties while swiping in different directions
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            onDismissed: (direction) {
              //Callback method executed after swiping
              final removedTask = task;
              setState(() => tasks.removeAt(index));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$removedTask removed'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() => tasks.insert(index, removedTask));
                    },
                  ),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(task),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/task_model.dart';
import '../services/firestore_service.dart';

import '../widgets/task_input_fields.dart';
import '../widgets/task_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final String currentUserEmail = "test@example.com"; // Replace with auth
  final _uuid = const Uuid();

  void _addTask(String title) {
    final task = Task(
      id: _uuid.v4(),
      title: title,
      ownerId: currentUserEmail,
      sharedWith: [currentUserEmail],
      completed: false,
    );
    _firestoreService.addTask(task);
  }

  void _toggleTask(Task task) {
    final updated = Task(
      id: task.id,
      title: task.title,
      ownerId: task.ownerId,
      sharedWith: task.sharedWith,
      completed: !task.completed,
    );
    _firestoreService.updateTask(updated);
  }

  void _deleteTask(Task task) {
    _firestoreService.deleteTask(task);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Shared TODOs')),
      body: Column(
        children: [
          TaskInputField(onSubmit: _addTask),
          StreamBuilder<List<Task>>(
            stream: _firestoreService.getTasks(currentUserEmail),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return TaskListView(onDelete: _deleteTask,tasks: snapshot.data!, onToggle: _toggleTask);
            },
          ),
        ],
      ),
    );
  }
}

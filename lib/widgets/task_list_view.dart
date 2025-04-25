import 'package:flutter/material.dart';
import '../model/task_model.dart';
import 'task_tile.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onToggle;
  final Function(Task) onDelete;

  const TaskListView({super.key, required this.tasks, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) => TaskTile(onDelete:onDelete, task: tasks[index], onToggle: onToggle),
      ),
    );
  }
}

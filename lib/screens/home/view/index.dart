import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubit/get_task_list_cubit/get_task_list_cubit.dart';
import 'package:uuid/uuid.dart';
import '../model/task_model.dart';
import '../../../services/firestore_service.dart';
import '../../../widgets/task_input_fields.dart';
import '../../../widgets/task_list_view.dart';


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
      sharedWith: [
        ""
      ],
      completed: false,
    );
    _firestoreService.addTask(task);
  }
@override
  void initState() {
    // TODO: implement initState
  context.read<GetTaskListCubit>().getTaskList();
  super.initState();
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
          BlocBuilder<GetTaskListCubit, GetTaskListState>(
            builder: (context, state) {
              if(state is GetTaskListLoaded){
                return TaskListView(
                    onDelete: _deleteTask,
                    tasks: state.list,
                    onToggle: _toggleTask);
              }else if(state is GetTaskListLoading){
                return Center(child: const CircularProgressIndicator());
              }else{
                return SizedBox();
              }

            },
          ),
          // StreamBuilder<List<Task>>(
          //   stream: _firestoreService.getTasks(currentUserEmail),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) return const CircularProgressIndicator();
          //     return TaskListView(onDelete: _deleteTask,tasks: snapshot.data!, onToggle: _toggleTask);
          //   },
          // ),
        ],
      ),
    );
  }
}

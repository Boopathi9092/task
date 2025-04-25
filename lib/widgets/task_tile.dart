import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../screens/home/model/task_model.dart';


class TaskTile extends StatelessWidget {
  final Task task;
  final Function(Task) onToggle;
  final Function(Task) onDelete;

  const TaskTile({super.key, required this.task, required this.onToggle,required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: SizedBox(
        width: 120,
        child: Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Checkbox(
              value: task.completed,
              onChanged: (_) => onToggle(task),
            ),
            const SizedBox(width: 4,),
            InkWell(
                onTap: ()=>onDelete(task),
                child: Icon(Icons.delete,size: 20,)),
            const SizedBox(width: 12,),
            InkWell(
                onTap: (){
                  Share.share(task.title);
                },
                child: Icon(Icons.share,size: 20,)),

          ],
        ),
      ),
    );
  }
}
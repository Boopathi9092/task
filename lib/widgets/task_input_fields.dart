import 'package:flutter/material.dart';

class TaskInputField extends StatelessWidget {
  final void Function(String) onSubmit;
  const TaskInputField({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            onSubmit(value);
            controller.clear();
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter task...',
          border: OutlineInputBorder(),
          suffixIcon: InkWell(
              onTap: (){
                if (controller.text.trim().isNotEmpty) {
                  onSubmit(controller.text);
                  controller.clear();
                }
              },
              child: Icon(Icons.add)),
        ),
      ),
    );
  }
}

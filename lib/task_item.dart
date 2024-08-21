import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => Provider.of<TaskProvider>(context, listen: false).removeTask(task.id),
      ),
      onTap: () => _showEditTaskDialog(context),
    );
  }

  void _showEditTaskDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final newTitle = titleController.text;
                if (newTitle.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(task.id, newTitle);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

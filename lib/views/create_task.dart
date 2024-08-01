import 'package:b2_backend/models/task.dart';
import 'package:b2_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Task"),
        ),
        body: Column(
          children: [
            TextField(
              controller: titleController,
            ),
            TextField(
              controller: descriptionController,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Title cannot be empty.')));
                  }
                  if (descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Description cannot be empty.')));
                  }
                  try {
                    isLoading = true;
                    setState(() {});
                    await TaskServices()
                        .createTask(TaskModel(
                            title: titleController.text,
                            isCompleted: false,
                            description: descriptionController.text))
                        .then((value) {
                      isLoading = false;
                      setState(() {});
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Task has been created successfully"),
                            );
                          });
                    });
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Create Task"))
          ],
        ),
      ),
    );
  }
}

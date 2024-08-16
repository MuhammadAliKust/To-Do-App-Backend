import 'dart:developer';

import 'package:b2_backend/models/task.dart';
import 'package:b2_backend/services/task.dart';
import 'package:b2_backend/views/create_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTasks(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                  trailing: IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices()
                              .deleteTask(taskList[i].docId.toString());
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      icon: Icon(Icons.delete)),
                );
              });
        },
      ),
    );
  }
}

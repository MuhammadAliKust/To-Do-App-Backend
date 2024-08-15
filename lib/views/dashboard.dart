import 'package:b2_backend/models/task.dart';
import 'package:b2_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getAllTasks(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> allTaskList = context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices().getCompletedTasks(),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();
                  return StreamProvider.value(
                      value: TaskServices().getInCompletedTasks(),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> inCompletedTaskList =
                            context.watch<List<TaskModel>>();
                        return Column(
                          children: [
                            Text(
                              "All Task: ${allTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Completed Task: ${completedTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "In Completed Task: ${inCompletedTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        );
                      });
                });
          }),
    );
  }
}

import 'dart:developer';

import 'package:b2_backend/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskServices {
  //Create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('taskCollection').doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection').doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  //Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({
      'title': model.title.toString(),
      'description': model.description.toString()
    });
  }

  //Delete Task
  Future deleteTask(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  //Get All Tasks
  Stream<List<TaskModel>> getAllTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map((taskList) => taskList.docs
            .map((singleTask) => TaskModel.fromJson(singleTask.data()))
            .toList());
  }

//Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((singleTask) => TaskModel.fromJson(singleTask.data()))
            .toList());
  }

//Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((singleTask) => TaskModel.fromJson(singleTask.data()))
            .toList());
  }

//Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }
}

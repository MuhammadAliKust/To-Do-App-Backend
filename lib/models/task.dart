// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? title;
  final String? description;
  final bool? isCompleted;
  final int? createdAt;
  final String? docId;

  TaskModel({
    this.title,
    this.description,
    this.isCompleted,
    this.createdAt,
    this.docId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        createdAt: json["createdAt"],
        docId: json["docID"],
      );

  Map<String, dynamic> toJson(String taskID) => {
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "docID": taskID,
      };
}

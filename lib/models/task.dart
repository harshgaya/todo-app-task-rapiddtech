import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? title;
  String? description;
  String? shortDescription;
  String? id;
  Timestamp? timestamp;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.timestamp,
      required this.shortDescription});
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'shortDescription': shortDescription,
      'id': id,
      'timestamp': timestamp,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        timestamp: json['timestamp'],
        shortDescription: json['shortDescription']);
  }
}

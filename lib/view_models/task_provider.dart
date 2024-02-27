import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  String? title;
  String? description;

  Future addTask(String title, String desc, BuildContext context) async {
    var uuid = Uuid();

    Task task = Task(
      title: title.trim(),
      description: desc.trim(),
      timestamp: Timestamp.now(),
      shortDescription:
          desc.trim().substring(0, desc.length > 20 ? 20 : desc.length),
      id: uuid.v4(),
    );
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(task.id)
          .set(task.toJson());

      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully.')));
      notifyListeners();
    } catch (e) {
      print('error $e');
      isLoading = false;
      notifyListeners();
    }
  }
}

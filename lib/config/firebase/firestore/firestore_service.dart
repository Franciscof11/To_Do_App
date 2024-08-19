import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class FirestoreService {
  final firestore = FirebaseFirestore.instance;
  Future<void> createTask({required Task task}) {
    return firestore
        .collection('tasks')
        .add(
          task.toMap(),
        )
        .then((value) => debugPrint("Task Added"))
        .catchError((error) => debugPrint("ERRO: $error"));
  }

  Future<void> updateTask({required Task task}) {
    return firestore.collection('tasks').doc(task.id.toString()).update(task.toMap()).then(
          (value) => debugPrint('Task updated!'),
          onError: (e) => debugPrint("Error: $e"),
        );
  }
}

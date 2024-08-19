import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class FirestoreService {
  Future<void> createTask({required Task task}) {
    return FirebaseFirestore.instance
        .collection('tasks')
        .add(
          task.toMap(),
        )
        .then((value) => debugPrint("Task Added"))
        .catchError((error) => debugPrint("ERRO: $error"));
  }
}

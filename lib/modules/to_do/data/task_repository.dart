import 'package:to_do_app/config/database/tasks/tasks_db.dart';
import 'package:to_do_app/config/firebase/firestore/firestore_service.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class TaskRepository {
  final _repository = TasksDB();
  final firestoreService = FirestoreService();

  Future<List<Task>> getAllTasks() {
    return _repository.getAllTasks();
  }

  Future<void> createTask({required Task task}) async {
    _repository.createTask(task: task);
  }

  Future<void> updateTask({required Task task}) {
    return _repository.updateTask(task: task);
  }

  Future<void> deleteTask({required int id}) {
    return _repository.deleteTask(id: id);
  }

  postToFirestore({required List<Task> tasks}) {
    for (var taskVar in tasks) {
      if (tasks.any((task) => task.id == taskVar.id)) {
        firestoreService.updateTask(task: taskVar);
      } else {
        firestoreService.createTask(task: taskVar);
      }
    }
  }
}

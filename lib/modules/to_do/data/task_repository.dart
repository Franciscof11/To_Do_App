import 'package:to_do_app/config/database/tasks/tasks_db.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class TaskRepository {
  final _repository = TasksDB();

  Future<List<Task>> getAllTasks() {
    return _repository.getAllTasks();
  }

  Future<void> createTask({required Task task}) {
    return _repository.createTask(task: task);
  }

  Future<void> updateTask({required Task task}) {
    return _repository.updateTask(task: task);
  }

  Future<void> deleteTask({required int id}) {
    return _repository.deleteTask(id: id);
  }
}

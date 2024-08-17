import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

import 'tasks_database_service.dart';

class TasksDB {
  final tableName = 'tasks';

  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
  "id" INTEGER NOT NULL,
  "title" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "isDone" INTEGER NOT NULL,
   PRIMARY KEY("id" AUTOINCREMENT)
    );""",
    );
  }

  Future<int> createTask({required Task task}) async {
    final database = await TasksDatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (title, description, isDone) VALUES (?,?,?)''',
      [
        task.title,
        task.description,
        task.isDone
      ],
    );
  }

  Future<List<Task>> getAllTasks() async {
    final database = await TasksDatabaseService().database;
    final task = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return task.map((task) => Task.fromMap(task)).toList();
  }
}

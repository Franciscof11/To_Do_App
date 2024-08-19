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
  "status" INTEGER NOT NULL,
   PRIMARY KEY("id" AUTOINCREMENT)
    );""",
    );
  }

  Future<int> createTask({required Task task}) async {
    final database = await TasksDatabaseService().database;
    final generatedTaskId = await database.insert(tableName, task.toMap());
    return generatedTaskId;
  }

  Future<List<Task>> getAllTasks() async {
    final database = await TasksDatabaseService().database;
    final tasks = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  Future<int> deleteTask({required int id}) async {
    final database = await TasksDatabaseService().database;
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [
        id
      ],
    );
  }

  Future<int> updateTask({required Task task}) async {
    final database = await TasksDatabaseService().database;
    return await database.update(
      tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [
        task.id
      ],
    );
  }

  Future<void> clearTable() async {
    final database = await TasksDatabaseService().database;
    await database.execute('DELETE FROM $tableName');
  }
}

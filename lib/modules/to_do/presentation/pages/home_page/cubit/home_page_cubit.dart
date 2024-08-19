import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final TaskRepository _repository;
  HomePageCubit({required TaskRepository repository})
      : _repository = repository,
        super(const HomePageState.initial());

  Future<void> getAllTasks() async {
    try {
      emit(const HomePageState.loading());

      final tasks = await _repository.getAllTasks();

      emit(HomePageState.data(tasks: tasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> createTask({required Task task}) async {
    try {
      emit(const HomePageState.loading());

      final creaTedtask = await _repository.createTask(task: task);

      print(creaTedtask.toString());

      _repository.createToFirestore(task: creaTedtask);

      final tasks = await _repository.getAllTasks();

      emit(HomePageState.data(tasks: tasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> updateTask({required Task task}) async {
    try {
      await _repository.updateTask(task: task);

/*       await _repository.updateToFirestore(task: task); */

      final tasks = await _repository.getAllTasks();

      emit(HomePageState.data(tasks: tasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> deleteTask({required int id}) async {
    try {
      await _repository.deleteTask(id: id);

/*       await _repository.deleteTask(id: id); */

      final tasks = await _repository.getAllTasks();

      emit(HomePageState.data(tasks: tasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> filterTasksByStatus({required Map<String, bool> filters}) async {
    try {
      emit(const HomePageState.loading());

      final tasks = await _repository.getAllTasks();

      List<Task> filteredTasks = [];

      if (filters['doneTasks'] == true) {
        final task = tasks.where((task) => task.status == 1);

        filteredTasks.addAll(task);
      }

      if (filters['toDoTasks'] == true) {
        final task = tasks.where((task) => task.status == 0);

        filteredTasks.addAll(task);
      }

      emit(HomePageState.data(tasks: filteredTasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> searchTask(String taskName) async {
    try {
      final tasks = await _repository.getAllTasks();

      final filteredTasks = tasks.where((task) => task.title.toLowerCase().contains(taskName.toLowerCase())).toList();

      emit(HomePageState.data(tasks: filteredTasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }

  Future<void> deleteAllDoneTasks() async {
    try {
      final originalTasks = await _repository.getAllTasks();

      final deletList = originalTasks.where((task) => task.status == 1).toList();

      for (var task in deletList) {
        deleteTask(id: task.id ?? 0);
      }

      final tasks = await _repository.getAllTasks();

      emit(HomePageState.data(tasks: tasks));
    } catch (e) {
      log(
        'Error! $e',
        error: e,
      );
      emit(HomePageState.error(message: 'Error! $e'));
    }
  }
}

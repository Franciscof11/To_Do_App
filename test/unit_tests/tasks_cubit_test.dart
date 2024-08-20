import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository repository;

  late HomePageCubit cubit;

  late List<Task> tasks;

  setUp(
    () {
      repository = MockTaskRepository();
      cubit = HomePageCubit(repository: repository);
      tasks = [
        Task.empty(),
        Task.empty(),
      ];
    },
  );

  blocTest<HomePageCubit, HomePageState>(
    'Test the get list of tasks function from bloc and repository instance.',
    setUp: () {
      when(() => repository.getAllTasks()).thenAnswer(
        (invocation) async => tasks,
      );
    },
    build: () => cubit,
    act: (bloc) => cubit.getAllTasks(),
    expect: () => [
      const HomePageState.loading(),
      HomePageState.data(tasks: tasks),
    ],
  );
}

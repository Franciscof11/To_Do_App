import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/config/database/tasks/tasks_db.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/create_task_page/create_task_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/loader.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/my_heat_map.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/search_widget.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/task_list_tile.dart';
import 'package:to_do_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, int>? dataset = {
      DateTime(2024, DateTime.august, 10): 1,
      DateTime(2024, DateTime.august, 13): 2,
      DateTime(2024, DateTime.august, 16): 3,
      DateTime(2024, DateTime.august, 18): 5,
    };

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: FloatingActionButton(
          onPressed: () async {
/*             final db = TasksDB();

            await db.clearTable();
 */
            Navigator.push(
              context,
              PageTransition(
                child: BlocProvider(
                  create: (context) => HomePageCubit(repository: context.read<TasksDB>()),
                  child: const CreateTaskPage(),
                ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.menu,
                  color: AppColors.mainGreen,
                  size: 30,
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    text: 'ToDo',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'App',
                        style: GoogleFonts.raleway(
                          color: AppColors.mainGreen,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: MyHeatMap(
                startDate: DateTime(2024, DateTime.august, 1),
                datasets: dataset,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BlocProvider(
                create: (context) => HomePageCubit(repository: context.read<TasksDB>()),
                child: const SearchWidget(),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Loader<HomePageCubit, HomePageState>(
                selector: (state) => state.maybeWhen(
                  orElse: () => false,
                  loading: () => true,
                ),
              ),
            ),
            BlocSelector<HomePageCubit, HomePageState, List<Task>>(
              selector: (state) => state.maybeWhen(
                orElse: () => [],
                data: (tasks) => tasks,
              ),
              builder: (context, tasks) {
                return Expanded(
                  child: RefreshIndicator(
                    color: AppColors.mainGreen,
                    onRefresh: () async {
                      for (var x in tasks) {
                        print(x.toString());
                      }
                      context.read<HomePageCubit>().getAllTasks();
                    },
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => BlocProvider(
                          create: (context) => HomePageCubit(repository: context.read<TasksDB>()),
                          child: TaskListTile(task: tasks[index]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

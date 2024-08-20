import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/create_task_page/create_task_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/filter_task_modal.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/home_drawer.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/loader.dart';
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
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade900,
      drawer: const HomeDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30, bottom: 35),
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              PageTransition(
                child: BlocProvider(
                  create: (context) => HomePageCubit(repository: context.read<TaskRepository>()),
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
          key: const Key('homePage'),
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: AppColors.mainGreen,
                    size: 30,
                  ),
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
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchWidget(
                modal: BlocProvider(
                  create: (context) => HomePageCubit(repository: context.read<TaskRepository>()),
                  child: FilterTaskModal(dialogContext: context),
                ),
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
                        itemBuilder: (context, index) => TaskListTile(task: tasks[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocSelector<HomePageCubit, HomePageState, List<Task>>(
              selector: (state) => state.maybeWhen(
                orElse: () => [],
                data: (tasks) => tasks,
              ),
              builder: (context, tasks) {
                final hasDoneTasks = tasks.any((task) => task.status == 1);
                return Visibility(
                  visible: hasDoneTasks,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45, bottom: 25, top: 25),
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomePageCubit>().deleteAllDoneTasks();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Deletar tarefas concluídas',
                            style: GoogleFonts.raleway(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

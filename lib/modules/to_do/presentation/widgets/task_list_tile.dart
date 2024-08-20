import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/edit_task_page/edit_task_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/home_page.dart';
import 'package:to_do_app/utils/app_colors.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  const TaskListTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    checkTask() {
      int toggleValue(int value) {
        if (value == 0) {
          return 1;
        } else if (value == 1) {
          return 0;
        } else {
          throw ArgumentError("O valor deve ser 0 ou 1");
        }
      }

      context.read<HomePageCubit>().updateTask(task: task.copyWith(status: toggleValue(task.status)));
    }

    final taskIsDone = task.status == 0 ? false : true;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: BlocProvider(
                          create: (context) => HomePageCubit(repository: context.read<TaskRepository>()),
                          child: EditTaskPage(task: task),
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 66, 66, 66),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            // Edit Option
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (modalContext) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 220),
                          child: Dialog(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tem certeza que deseja excluir essa tarefa?',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(modalContext);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.mainGreen,
                                            padding: const EdgeInsets.all(15),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          child: Text(
                                            'Cancelar',
                                            style: GoogleFonts.raleway(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<HomePageCubit>()
                                                .deleteTask(
                                                  id: task.id ?? 0,
                                                )
                                                .then(
                                              (value) {
                                                Navigator.pop(modalContext);
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType.fade,
                                                    child: BlocProvider(
                                                      create: (context) => HomePageCubit(repository: context.read<TaskRepository>())..getAllTasks(),
                                                      child: const HomePage(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.all(15),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          child: Text(
                                            'Excluir',
                                            style: GoogleFonts.raleway(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: taskIsDone ? Colors.green : Colors.white24,
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: taskIsDone ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                if (task.description != '')
                  Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.raleway(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: taskIsDone ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
              ],
            ),
            trailing: Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.grey.shade900,
              value: taskIsDone,
              onChanged: (value) {
                checkTask();
              },
            ),
          ),
        ),
      ),
    );
  }
}

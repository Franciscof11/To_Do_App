import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';

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
            // Edit Option
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color.fromARGB(255, 66, 66, 66),
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8),
            ),

            // Delete Option
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: taskIsDone ? Colors.green : Theme.of(context).colorScheme.secondary,
            ),
            child: ListTile(
              title: Text(
                task.title,
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
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
      ),
    );
  }
}

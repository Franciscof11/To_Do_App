import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  const TaskListTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final taskIsDone = task.isDone == 0 ? false : true;
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
                activeColor: Theme.of(context).colorScheme.inversePrimary,
                value: taskIsDone,
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

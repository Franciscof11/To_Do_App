import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';
import 'package:to_do_app/modules/to_do/presentation/widgets/my_heat_map.dart';
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
    List<Task> tasks1 = <Task>[];

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
          onPressed: () => (),
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
            const SizedBox(height: 30),
            Center(
              child: MyHeatMap(
                startDate: DateTime(2024, DateTime.august, 1),
                datasets: dataset,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) => TaskListTile(
                  task: Task(
                    id: 1,
                    title: 'Do laundry',
                    isDone: false,
                    description: 'Have to do laundry',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

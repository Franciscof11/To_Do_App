import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/utils/app_colors.dart';

class FilterTaskModal extends StatefulWidget {
  final BuildContext dialogContext;
  const FilterTaskModal({super.key, required this.dialogContext});

  @override
  State<FilterTaskModal> createState() => _FilterTaskModalState();
}

class _FilterTaskModalState extends State<FilterTaskModal> {
  bool doneTasks = false;
  bool toDoTasks = false;

  @override
  Widget build(BuildContext context) {
    Map<String, bool> filters = {
      'doneTasks': doneTasks,
      'toDoTasks': toDoTasks,
    };
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Filtrar tarefas',
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tarefas concluídas',
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Switch.adaptive(
                      value: doneTasks,
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.mainGreen,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[700],
                      onChanged: (value) {
                        setState(() {
                          doneTasks = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tarefas pendentes',
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Switch.adaptive(
                      value: toDoTasks,
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.mainGreen,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[700],
                      onChanged: (value) {
                        setState(() {
                          toDoTasks = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.dialogContext.read<HomePageCubit>().filterTasksByStatus(filters: filters);
                    if (!doneTasks && !toDoTasks) {
                      print('alo');
                      widget.dialogContext.read<HomePageCubit>().getAllTasks();
                    }

                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainGreen,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Aplicar Filtros',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

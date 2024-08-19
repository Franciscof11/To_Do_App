import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';

class SearchWidget extends StatefulWidget {
  final Widget modal;
  const SearchWidget({super.key, required this.modal});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (value) => context.read<HomePageCubit>().searchTask(value),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar tarefas',
                      hintStyle: GoogleFonts.raleway(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.workSans(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (dialogContext) => widget.modal,
              barrierColor: Colors.grey.shade100.withOpacity(0.7),
              shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(85))),
            );
          },
          child: Icon(Icons.tune, color: Colors.grey[200], size: 30),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Widget? prefixIcon;
  final bool isSecret;
  final TextEditingController? controller;

  final bool isLarge;
  final bool isOptional;
  final bool isNumber;
  const CustomTextField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.isSecret = false,
    this.controller,
    this.isLarge = false,
    this.isOptional = false,
    this.isNumber = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              textAlign: TextAlign.justify,
              style: GoogleFonts.raleway(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: widget.isLarge ? null : 1,
          controller: widget.controller,
          keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          obscureText: obscureText,
          cursorColor: AppColors.mainGreen,
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 16,
          ),
          validator: (value) {
            if (widget.isOptional) {
              return null;
            }

            if (value == null || value.isEmpty) {
              return 'Campo Obrigatório!';
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: widget.isSecret
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            prefixIcon: widget.prefixIcon,
            errorStyle: GoogleFonts.raleway(
              color: Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.mainGreen!, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.mainGreen!, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

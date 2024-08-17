import 'package:flutter/material.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';

class AplleSignInButton extends StatelessWidget {
  final String urlImage;

  const AplleSignInButton({
    super.key,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AuthRepository().signInWithApple(),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey[200], border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            urlImage,
            height: 55,
          ),
        ),
      ),
    );
  }
}

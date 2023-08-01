import 'package:flutter/material.dart';

class AppbarText extends StatelessWidget {
  final String text;

  const AppbarText({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0.5),
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}

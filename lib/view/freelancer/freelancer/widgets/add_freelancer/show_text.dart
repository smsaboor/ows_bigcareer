import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  const ShowText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black),
      ),
    );
  }
}

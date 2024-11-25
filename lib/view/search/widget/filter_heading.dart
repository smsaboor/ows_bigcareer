import 'package:flutter/material.dart';

class FilterHeading extends StatelessWidget {
  const FilterHeading({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

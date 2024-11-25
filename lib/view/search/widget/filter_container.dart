import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({Key? key, required this.title,required this.isSelected}) : super(key: key);
  final title;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: isSelected?Colors.indigo:Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5)),
        height: 40,
        width: MediaQuery.of(context).size.width * .3,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600,color: isSelected?Colors.white:Colors.black),
          ),
        ));
  }
}

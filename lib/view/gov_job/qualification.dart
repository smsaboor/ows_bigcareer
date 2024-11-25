import 'package:flutter/material.dart';

class QualificationDialog extends StatefulWidget {
  const QualificationDialog(
      {Key? key,
      required this.onChanged,
      required this.initialValue,
      required this.height})
      : super(key: key);
  final initialValue;
  final onChanged;
  final height;

  @override
  State<QualificationDialog> createState() => _QualificationDialogState();
}

class _QualificationDialogState extends State<QualificationDialog> {
  var qualificationList = [
    "8th",
    "Highschool",
    "Intermediate",
    "Graduation",
    "Postgraduation"
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.only(left: 5.0),
        decoration: myBoxDecoration(),
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton<String>(
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: widget.initialValue,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: qualificationList.map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: widget.onChanged),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}

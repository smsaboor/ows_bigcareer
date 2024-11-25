import 'package:flutter/material.dart';

class BigCareerDropDown extends StatefulWidget {
  const BigCareerDropDown(
      {Key? key,
      required this.value,
      required this.valueList,
      required this.onChange})
      : super(key: key);
  final value;
  final onChange;
  final List<String> valueList;

  @override
  State<BigCareerDropDown> createState() => _BigCareerDropDownState();
}

class _BigCareerDropDownState extends State<BigCareerDropDown> {
  List<DropdownMenuItem<Object>>? dropList;

  @override
  void initState() {
    // TODO: implement initState
    dropList = widget.valueList.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList();
    super.initState();
  }

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
        height: 40,
        //
        width: MediaQuery.of(context).size.width,
        //          <// --- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
              // Initial Value
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: widget.value,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: dropList,
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: widget.onChange),
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

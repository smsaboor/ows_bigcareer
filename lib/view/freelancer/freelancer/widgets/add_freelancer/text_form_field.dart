import 'package:flutter/material.dart';

class FreelancerTextFromField extends StatefulWidget {
  const FreelancerTextFromField({Key? key,required this.controllerL,
    required this.heightL,
    required this.maxLineL,
    required this.hint,
    required this.maxLine,
    required this.error1,
    required this.error2,
    required this.con1,
  }) : super(key: key);
 final controllerL, heightL,
  maxLineL, hint, maxLine, error1, error2, con1;
  @override
  State<FreelancerTextFromField> createState() => _FreelancerTextFromFieldState();
}

class _FreelancerTextFromFieldState extends State<FreelancerTextFromField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightL,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        maxLines: widget.maxLineL,
        controller: widget.controllerL,
        maxLength: widget.maxLine,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.error1;
          } else {}
          if (value!.length < widget.con1) {
            return widget.error2;
          } else {}
          return null;
        },
        onChanged: (v) {
          setState(() {});
        },
        decoration: InputDecoration(
          isDense: false,
          isCollapsed: false,
          contentPadding: const EdgeInsets.fromLTRB(15,0,15,0),
          hintText: widget.hint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo)),
        ),
      ),
    );
  }
}

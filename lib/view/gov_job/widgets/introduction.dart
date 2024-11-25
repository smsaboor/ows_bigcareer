import 'package:flutter/material.dart';

class ExpansionTileIntroduction extends StatelessWidget {
  const ExpansionTileIntroduction(
      {Key? key, required this.data, required this.flag})
      : super(key: key);
  final data;
  final flag;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: flag,
      collapsedBackgroundColor: Colors.orange,
      collapsedIconColor: Colors.black,
      collapsedTextColor: Colors.black,
      iconColor: Colors.black,
      title: const Text(
        'Instructions',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Job Name',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5),
          child: Text(
            data.jobTitle!,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10,),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'How to Apply?',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5),
          child: Text(
            data.howToApply!,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              ' Eligibility:',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 10),
          child: Text(
            data.howToApply!,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              ' Other Details:',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 10),
          child: Text(
            data.other!,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

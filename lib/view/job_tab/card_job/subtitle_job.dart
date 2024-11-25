import 'package:flutter/material.dart';
import 'package:ows_bigcareer/core/constants/jobs2.dart';

class SubTitleJob extends StatelessWidget {
  const SubTitleJob({Key? key, required this.index,required this.height}) : super(key: key);
  final index;
  final height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 25),
        child: Column(
          children: [
            Text(
              '${jobs2[index]['title']}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

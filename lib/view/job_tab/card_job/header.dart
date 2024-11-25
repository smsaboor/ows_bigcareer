import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';

class HeaderJobCard extends StatelessWidget {
  const HeaderJobCard(
      {Key? key,
      required this.jobs,
      required this.apiResponse,
      required this.height,
      required this.width})
      : super(key: key);
  final ModelJobsFinal jobs;
  final height, width, apiResponse;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(20),
              ),
              color: Color(0xff1aa122)),
          height: height,
          width: width,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  jobs!.totalApplied!,
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  ' Job Applied',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
    );
  }
}

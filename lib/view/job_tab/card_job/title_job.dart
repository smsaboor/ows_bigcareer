import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';

class TitleJob extends StatelessWidget {
  const TitleJob({Key? key, required this.jobs,required this.height}) : super(key: key);
  final ModelJobsFinal jobs;
  final height;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,top: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                jobs.jobTitle!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0,right: 10),
              child: Text(
                '${jobs.jobDescription}',
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

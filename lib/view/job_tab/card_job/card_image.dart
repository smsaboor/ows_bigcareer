import 'package:flutter/material.dart';
import 'package:ows_bigcareer/core/constants/jobs2.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';

class ImageJobCard extends StatelessWidget {
  const ImageJobCard({Key? key, required this.jobs, required this.height,
    required this.width}) : super(key: key);
  final ModelJobsFinal jobs;
  final height,width;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: jobs.companyLogo!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    // return SizedBox(
    //   height: height,
    //   width: width,
    //   child:Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: Image.network(jobs2[index]['image']!,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: null /* add child content here */,
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Image.network(jobs2[index]['image']!,
    //         fit: BoxFit.fitHeight, width: width),
    //   ),
    // );
  }
}

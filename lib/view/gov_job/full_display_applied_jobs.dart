import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/models/model_job_applied_response.dart';

class FullDisplayAppliedJob extends StatefulWidget {
  const FullDisplayAppliedJob({Key? key, required this.data}) : super(key: key);
  final ModelJobsAppliedResponse data;

  @override
  State<FullDisplayAppliedJob> createState() => _FullDisplayAppliedJobState();
}

class _FullDisplayAppliedJobState extends State<FullDisplayAppliedJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Applied Jobs'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  widget.data!.jobTitle ?? '',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(height: 20,),
                displayWidget('Applied Date', widget.data.dateTime ?? ''),
                displayWidget('Applicant Name', widget.data.name ?? ''),
                displayWidget('Dob: ', widget.data.dob.toString() ?? ''),
                displayWidget('Mobile:', widget.data.mobile ?? ''),
                displayWidget(
                    'Alternative Mobile:', widget.data.alternateNumber ?? ''),
                displayWidget('gender:', widget.data.gender ?? ''),
                displayWidget(
                    'qualification:', widget.data.qualification ?? ''),
                displayWidget('father Name', widget.data.fathername ?? ''),
                displayWidget('Mother Name', widget.data.mothername ?? ''),
                displayWidget('state', widget.data.state ?? ''),
                displayWidget('district:', widget.data.district ?? ''),
                displayWidget('city', widget.data.city ?? ''),
                displayWidget('Pin code', widget.data.pincode ?? ''),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.data.degree1!.toUpperCase() ?? '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      displayWidget2('Degree', widget.data.degree1 ?? ''),
                      displayWidget2(
                          'SchoolName', widget.data.highSchoolName ?? ''),
                      displayWidget2('Completed Year',
                          widget.data.highSchoolCompleteYear.toString() ?? ''),
                      displayWidget2(
                          'Total', widget.data.highSchoolTotalMarks ?? ''),
                      displayWidget2(
                          'Percentage', widget.data.highSchoolPercentage ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.data.degree2!.toUpperCase() ?? '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      displayWidget2('Degree', widget.data.degree2 ?? ''),
                      displayWidget2(
                          'SchoolName', widget.data.interSchoolName ?? ''),
                      displayWidget2('Completed Year',
                          widget.data.interSchoolCompleteYear.toString() ?? ''),
                      displayWidget2(
                          'Total', widget.data.interSchoolTotalMarks ?? ''),
                      displayWidget2(
                          'Percentage', widget.data.interSchoolPercentage ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.data.degree3!.toUpperCase() ?? '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      displayWidget2('Degree', widget.data.degree3 ?? ''),
                      displayWidget2(
                          'SchoolName', widget.data.graduationName ?? ''),
                      displayWidget2('Completed Year',
                          widget.data.graduationCompleteYear.toString() ?? ''),
                      displayWidget2(
                          'Total', widget.data.graduationTotalMarks ?? ''),
                      displayWidget2(
                          'Percentage', widget.data.graduationPercentage ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.data.degree4!.toUpperCase() ?? '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      displayWidget2('Degree', widget.data.degree4 ?? ''),
                      displayWidget2(
                          'SchoolName', widget.data.postGraduationName ?? ''),
                      displayWidget2('Completed Year',
                          widget.data.postGraduationCompleteYear.toString() ?? ''),
                      displayWidget2(
                          'Total', widget.data.postGraduationTotalMarks ?? ''),
                      displayWidget2(
                          'Percentage', widget.data.postGraduationPercentage ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15),
                  child: SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        widget.data.image1.toString().contains('http')?
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.data.image1!)):Container(),
                        SizedBox(width: 3,),
                        widget.data.image2.toString().contains('http')?
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.data.image2!)):Container(),
                        SizedBox(width: 3,),
                        widget.data.image3.toString().contains('http')?
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.data.image3!)):Container(),
                        SizedBox(width: 3,),
                        widget.data.image4.toString().contains('http')?
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.data.image4!)):Container(),
                        SizedBox(width: 3,),
                        widget.data.image5.toString().contains('http')?
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.data.image5!)):Container(),
                      ],),

                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayWidget(String title, String details) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 3.0, right: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*.30,
            child: Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.40,
            child: Text(
              details ?? '',
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
  Widget displayWidget2(String title, String details) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 3.0, right: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*.25,
            child: Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.45,
            child: Text(
              details ?? '',
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

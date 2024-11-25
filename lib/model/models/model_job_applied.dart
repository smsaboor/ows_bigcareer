// To parse this JSON data, do
//
//     final modelJobsApplied = modelJobsAppliedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelJobsApplied modelJobsAppliedFromJson(String str) => ModelJobsApplied.fromJson(json.decode(str));

String modelJobsAppliedToJson(ModelJobsApplied data) => json.encode(data.toJson());

class ModelJobsApplied {
  ModelJobsApplied({
    @required this.jobId,
    @required this.userId,
    @required this.name,
    @required this.mobile,
    @required this.alternateNumber,
    @required this.email,
    @required this.dob,
    @required this.gender,
    @required this.qualification,
    @required this.fathername,
    @required this.mothername,
    @required this.state,
    @required this.district,
    @required this.city,
    @required this.pincode,
    @required this.degree1,
    @required this.highSchoolName,
    @required this.highSchoolPercentage,
    @required this.highSchoolTotalMarks,
    @required this.highSchoolCompleteYear,
    @required this.degree2,
    @required this.interSchoolName,
    @required this.interSchoolTotalMarks,
    @required this.interSchoolCompleteYear,
    @required this.degree3,
    @required this.graduationName,
    @required this.graduationPercentage,
    @required this.graduationTotalMarks,
    @required this.graduationCompleteYear,
    @required this.degree4,
    @required this.postGraduationName,
    @required this.postGraduationPercentage,
    @required this.postGraduationTotalMarks,
    @required this.postGraduationCompleteYear,
    @required this.other,
    @required this.image1,
    @required this.image2,
    @required this.image3,
    @required this.image4,
    @required this.image5,
  });

  String? jobId;
  String? userId;
  String? name;
  String? mobile;
  String? alternateNumber;
  String? email;
  String? dob;
  String? gender;
  String? qualification;
  String? fathername;
  String? mothername;
  String? state;
  String? district;
  String? city;
  String? pincode;
  String? degree1;
  String? highSchoolName;
  String? highSchoolPercentage;
  String? highSchoolTotalMarks;
  String? highSchoolCompleteYear;
  String? degree2;
  String? interSchoolName;
  String? interSchoolTotalMarks;
  String? interSchoolCompleteYear;
  String? degree3;
  String? graduationName;
  String? graduationPercentage;
  String? graduationTotalMarks;
  String? graduationCompleteYear;
  String? degree4;
  String? postGraduationName;
  String? postGraduationPercentage;
  String? postGraduationTotalMarks;
  String? postGraduationCompleteYear;
  String? other;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;

  factory ModelJobsApplied.fromJson(Map<String, dynamic> json) => ModelJobsApplied(
    jobId: json["job_id"],
    userId: json["user_id"],
    name: json["name"],
    mobile: json["mobile"],
    alternateNumber: json["alternate_number"],
    email: json["email"],
    dob: json["dob"],
    gender: json["gender"],
    qualification: json["qualification"],
    fathername: json["fathername"],
    mothername: json["mothername"],
    state: json["state"],
    district: json["district"],
    city: json["city"],
    pincode: json["pincode"],
    degree1: json["degree_1"],
    highSchoolName: json["high_school_name"],
    highSchoolPercentage: json["high_school_percentage"],
    highSchoolTotalMarks: json["high_school_total_marks"],
    highSchoolCompleteYear: json["high_school_complete_year"],
    degree2: json["degree_2"],
    interSchoolName: json["inter_school_name"],
    interSchoolTotalMarks: json["inter_school_total_marks"],
    interSchoolCompleteYear: json["inter_school_complete_year"],
    degree3: json["degree_3"],
    graduationName: json["graduation_name"],
    graduationPercentage: json["graduation_percentage"],
    graduationTotalMarks: json["graduation_total_marks"],
    graduationCompleteYear: json["graduation_complete_year"],
    degree4: json["degree_4"],
    postGraduationName: json["post_graduation_name"],
    postGraduationPercentage: json["post_graduation_percentage"],
    postGraduationTotalMarks: json["post_graduation_total_marks"],
    postGraduationCompleteYear: json["post_graduation_complete_year"],
    other: json["other"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "user_id": userId,
    "name": name,
    "mobile": mobile,
    "alternate_number": alternateNumber,
    "email": email,
    "dob": dob,
    "gender": gender,
    "qualification": qualification,
    "fathername": fathername,
    "mothername": mothername,
    "state": state,
    "district": district,
    "city": city,
    "pincode": pincode,
    "degree_1": degree1,
    "high_school_name": highSchoolName,
    "high_school_percentage": highSchoolPercentage,
    "high_school_total_marks": highSchoolTotalMarks,
    "high_school_complete_year": highSchoolCompleteYear,
    "degree_2": degree2,
    "inter_school_name": interSchoolName,
    "inter_school_total_marks": interSchoolTotalMarks,
    "inter_school_complete_year": interSchoolCompleteYear,
    "degree_3": degree3,
    "graduation_name": graduationName,
    "graduation_percentage": graduationPercentage,
    "graduation_total_marks": graduationTotalMarks,
    "graduation_complete_year": graduationCompleteYear,
    "degree_4": degree4,
    "post_graduation_name": postGraduationName,
    "post_graduation_percentage": postGraduationPercentage,
    "post_graduation_total_marks": postGraduationTotalMarks,
    "post_graduation_complete_year": postGraduationCompleteYear,
    "other": other,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
  };
}

// To parse this JSON data, do
//
//     final modelJobsAppliedResponse = modelJobsAppliedResponseFromJson(jsonString);

import 'dart:convert';

// List<ModelJobsAppliedResponse> modelJobsAppliedResponseFromJson(String str) => List<ModelJobsAppliedResponse>.from(json.decode(str).map((x) => ModelJobsAppliedResponse.fromJson(x)));

String modelJobsAppliedResponseToJson(List<ModelJobsAppliedResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelJobsAppliedResponse {
  ModelJobsAppliedResponse({
    this.response,
    this.jobId,
    this.totalJobs,
    this.jobTitle,
    this.userId,
    this.name,
    this.mobile,
    this.alternateNumber,
    this.email,
    this.dob,
    this.gender,
    this.qualification,
    this.fathername,
    this.mothername,
    this.state,
    this.district,
    this.city,
    this.pincode,
    this.degree1,
    this.highSchoolName,
    this.highSchoolPercentage,
    this.highSchoolTotalMarks,
    this.highSchoolCompleteYear,
    this.degree2,
    this.interSchoolName,
    this.interSchoolPercentage,
    this.interSchoolTotalMarks,
    this.interSchoolCompleteYear,
    this.degree3,
    this.graduationName,
    this.graduationPercentage,
    this.graduationTotalMarks,
    this.graduationCompleteYear,
    this.degree4,
    this.postGraduationName,
    this.postGraduationPercentage,
    this.postGraduationTotalMarks,
    this.postGraduationCompleteYear,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.other,
    this.dateTime,
  });

  String? response;
  String? jobId;
  String? totalJobs;
  String? jobTitle;
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
  String? interSchoolPercentage;
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
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? other;
  String? dateTime;

  // factory ModelJobsAppliedResponse.fromJson(Map<String, dynamic> json) => ModelJobsAppliedResponse(
  //   response: json["response"],
  //   jobId: json["job_id"],
  //   totalJobs: json["total_jobs"],
  //   jobTitle: json["job_title"],
  //   userId: json["user_id"],
  //   name: json["name"],
  //   mobile: json["mobile"],
  //   alternateNumber: json["alternate_number"],
  //   email: json["email"],
  //   dob: DateTime.parse(json["dob"]),
  //   gender: json["gender"],
  //   qualification: json["qualification"],
  //   fathername: json["fathername"],
  //   mothername: json["mothername"],
  //   state: json["state"],
  //   district: json["district"],
  //   city: json["city"],
  //   pincode: json["pincode"],
  //   degree1: json["degree_1"],
  //   highSchoolName: json["high_school_name"],
  //   highSchoolPercentage: json["high_school_percentage"],
  //   highSchoolTotalMarks: json["high_school_total_marks"],
  //   highSchoolCompleteYear: DateTime.parse(json["high_school_complete_year"]),
  //   degree2: json["degree_2"],
  //   interSchoolName: json["inter_school_name"],
  //   interSchoolPercentage: json["inter_school_percentage"],
  //   interSchoolTotalMarks: json["inter_school_total_marks"],
  //   interSchoolCompleteYear: json["inter_school_complete_year"],
  //   degree3: json["degree_3"],
  //   graduationName: json["graduation_name"],
  //   graduationPercentage: json["graduation_percentage"],
  //   graduationTotalMarks: json["graduation_total_marks"],
  //   graduationCompleteYear: json["graduation_complete_year"],
  //   degree4: json["degree_4"],
  //   postGraduationName: json["post_graduation_name"],
  //   postGraduationPercentage: json["post_graduation_percentage"],
  //   postGraduationTotalMarks: json["post_graduation_total_marks"],
  //   postGraduationCompleteYear: json["post_graduation_complete_year"],
  //   image1: json["image1"],
  //   image2: json["image2"],
  //   image3: json["image3"],
  //   image4: json["image4"],
  //   image5: json["image5"],
  //   other: json["other"],
  //   dateTime: json["date_time"],
  // );

   fromJson(Map<String, dynamic> json) {
     print('-saboor josn:  ${json}');
     print('-saboor josn:  ${json["date_time"]}');
     print('-saboor josn:  ${json["date_time"].runtimeType}');
     return ModelJobsAppliedResponse(
         response: json["response"],
         jobId: json["job_id"],
         totalJobs: json["total_jobs"],
         jobTitle: json["job_title"],
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
         highSchoolCompleteYear:  json["high_school_complete_year"],
         degree2: json["degree_2"],
         interSchoolName: json["inter_school_name"],
         interSchoolPercentage: json["inter_school_percentage"],
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
         image1: json["image1"],
         image2: json["image2"],
         image3: json["image3"],
         image4: json["image4"],
         image5: json["image5"],
         dateTime: json["date_time"],
         other: json["other"]??''
     );
   }

  Map<String, dynamic> toJson() => {
    "response": response,
    "job_id": jobId,
    "total_jobs": totalJobs,
    "job_title": jobTitle,
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
    "inter_school_percentage": interSchoolPercentage,
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
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5":image5,
    "other": other??'',
    "date_time": dateTime
  };
}

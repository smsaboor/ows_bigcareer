// To parse this JSON data, do
//
//     final modelJobsLatest = modelJobsLatestFromJson(jsonString);

import 'dart:convert';

ModelJobsLatest modelJobsLatestFromJson(String str) => ModelJobsLatest.fromJson(json.decode(str));

String modelJobsLatestToJson(ModelJobsLatest data) => json.encode(data.toJson());

class ModelJobsLatest {
  ModelJobsLatest({
    this.successCode,
    this.data,
  });

  String? successCode;
  List<DataJobsLatest>? data;

  factory ModelJobsLatest.fromJson(Map<String, dynamic> json) => ModelJobsLatest(
    successCode: json["success_code"],
    data: List<DataJobsLatest>.from(json["data"].map((x) => DataJobsLatest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success_code": successCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataJobsLatest {
  DataJobsLatest({
    this.id,
    this.companyLogo,
    this.jobTitle,
    this.jobDescription,
    this.jobCategoryId,
    this.jobOppId,
    this.educationQualication,
    this.requirements,
    this.responsibilities,
    this.jobType,
    this.stateId,
    this.cityId,
    this.experience,
    this.noOpenings,
    this.howToApply,
    this.eligibity,
    this.other,
    this.declaration,
    this.lastDate,
    this.postDate,
    this.jobLocationId,
    this.postedDate,
    this.companyName,
    this.salary,
    this.likes,
  });

  String? id;
  String? companyLogo;
  String? jobTitle;
  String? jobDescription;
  String? jobCategoryId;
  String? jobOppId;
  String? educationQualication;
  String? requirements;
  String? responsibilities;
  String? jobType;
  String? stateId;
  String? cityId;
  String? experience;
  String? noOpenings;
  String? howToApply;
  String? eligibity;
  String? other;
  String? declaration;
  String? lastDate;
  String? postDate;
  String? jobLocationId;
  DateTime? postedDate;
  String? companyName;
  String? salary;
  dynamic likes;

  factory DataJobsLatest.fromJson(Map<String, dynamic> json) => DataJobsLatest(
    id: json["id"],
    companyLogo: json["company_logo"],
    jobTitle: json["job_title"],
    jobDescription: json["job_description"],
    jobCategoryId: json["job_category_id"],
    jobOppId: json["job_opp_id"],
    educationQualication: json["education_qualication"],
    requirements: json["requirements"],
    responsibilities: json["responsibilities"],
    jobType: json["job_type"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    experience: json["experience"],
    noOpenings: json["no_openings"],
    howToApply: json["howToApply"],
    eligibity: json["eligibity"],
    other: json["other"],
    declaration: json["declaration"],
    lastDate: json["last_date"],
    postDate: json["post_date"],
    jobLocationId: json["job_location_id"],
    postedDate: DateTime.parse(json["posted_date"]),
    companyName: json["company_name"],
    salary: json["salary"],
    likes: json["likes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_logo": companyLogo,
    "job_title": jobTitle,
    "job_description": jobDescription,
    "job_category_id": jobCategoryId,
    "job_opp_id": jobOppId,
    "education_qualication": educationQualication,
    "requirements": requirements,
    "responsibilities": responsibilities,
    "job_type": jobType,
    "state_id": stateId,
    "city_id": cityId,
    "experience": experience,
    "no_openings": noOpenings,
    "howToApply": howToApply,
    "eligibity": eligibity,
    "other": other,
    "declaration": declaration,
    "last_date": lastDate,
    "post_date": postDate,
    "job_location_id": jobLocationId,
    "posted_date": postedDate,
    "company_name": companyName,
    "salary": salary,
    "likes": likes,
  };
}

// To parse this JSON data, do
//
//     final modelJobs = modelJobsFromJson(jsonString);

import 'dart:convert';

List<ModelJobsFinal> modelJobsFromJson(String str) => List<ModelJobsFinal>.from(json.decode(str).map((x) => ModelJobsFinal.fromJson(x)));

String modelJobsToJson(List<ModelJobsFinal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelJobsFinal {
  ModelJobsFinal({
    this.successCode,
    this.jobId,
    this.totalApplied,
    this.jobTitle,
    this.companyName,
    this.companyLogo,
    this.salary,
    this.experience,
    this.jobLocationId,
    this.jobDescription,
    this.requirements,
    this.educationQualication,
    this.responsibilities,
    this.noOpenings,
    this.howToApply,
    this.eligibity,
    this.other,
    this.declaration,
    this.lastDate,
    this.postDate,
    this.postedDate,
  });

  String? successCode;
  String? jobId;
  String? totalApplied;
  String? jobTitle;
  String? companyName;
  String? companyLogo;
  String? salary;
  String? experience;
  String? jobLocationId;
  String? jobDescription;
  String? requirements;
  String? educationQualication;
  String? responsibilities;
  String? noOpenings;
  String? howToApply;
  String? eligibity;
  String? other;
  String? declaration;
  String? lastDate;
  String? postDate;
  String? postedDate;

  factory ModelJobsFinal.fromJson(Map<String, dynamic> json) => ModelJobsFinal(
    successCode: json["success_code"],
    jobId: json["job_id"],
    totalApplied: json["total_applied"],
    jobTitle: json["job_title"],
    companyName: json["company_name"],
    companyLogo: json["company_logo"],
    salary: json["salary"],
    experience: json["experience"],
    jobLocationId: json["job_location_id"],
    jobDescription: json["job_description"],
    requirements: json["requirements"],
    educationQualication: json["education_qualication"],
    responsibilities: json["responsibilities"],
    noOpenings: json["no_openings"],
    howToApply: json["howToApply"],
    eligibity: json["eligibity"],
    other: json["other"],
    declaration: json["declaration"],
    lastDate: json["last_date"],
    postDate: json["post_date"],
    postedDate: json["posted_date"],
  );
 fromJson(Map<String, dynamic> json) => ModelJobsFinal(
    successCode: json["success_code"],
    jobId: json["job_id"],
    totalApplied: json["total_applied"],
    jobTitle: json["job_title"],
    companyName: json["company_name"],
   companyLogo: json["company_logo"],
    salary: json["salary"],
    experience: json["experience"],
    jobLocationId: json["job_location_id"],
    jobDescription: json["job_description"],
    requirements: json["requirements"],
    educationQualication: json["education_qualication"],
    responsibilities: json["responsibilities"],
    noOpenings: json["no_openings"],
    howToApply: json["howToApply"],
    eligibity: json["eligibity"],
    other: json["other"],
    declaration: json["declaration"],
    lastDate: json["last_date"],
    postDate: json["post_date"],
    postedDate: json["posted_date"],
  );


  Map<String, dynamic> toJson() => {
    "success_code": successCode,
    "job_id": jobId,
    "total_applied": totalApplied,
    "job_title": jobTitle,
    "company_name": companyName,
    "company_logo": companyLogo,
    "salary": salary,
    "experience": experience,
    "job_location_id": jobLocationId,
    "job_description": jobDescription,
    "requirements": requirements,
    "education_qualication": educationQualication,
    "responsibilities": responsibilities,
    "no_openings": noOpenings,
    "howToApply": howToApply,
    "eligibity": eligibity,
    "other": other,
    "declaration": declaration,
    "last_date": lastDate,
    "post_date": postDate,
    "posted_date": postedDate,
  };
}

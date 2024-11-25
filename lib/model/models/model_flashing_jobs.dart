// To parse this JSON data, do
//
//     final modelFlashingJobs = modelFlashingJobsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ModelFlashingJobs> modelFlashingJobsFromJson(String str) => List<ModelFlashingJobs>.from(json.decode(str).map((x) => ModelFlashingJobs.fromJson(x)));

String modelFlashingJobsToJson(List<ModelFlashingJobs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFlashingJobs {
  ModelFlashingJobs({
    @required this.jobOppId,
    @required this.jobName,
  });

  String? jobOppId;
  String? jobName;

  factory ModelFlashingJobs.fromJson(Map<String, dynamic> json) => ModelFlashingJobs(
    jobOppId: json["job_opp_id"],
    jobName: json["job_name"],
  );
 fromJson(Map<String, dynamic> json) => ModelFlashingJobs(
    jobOppId: json["job_opp_id"],
    jobName: json["job_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_opp_id": jobOppId,
    "job_name": jobName,
  };
}

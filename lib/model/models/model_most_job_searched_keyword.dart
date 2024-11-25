// To parse this JSON data, do
//
//     final modelMostJobSearchedKeyword = modelMostJobSearchedKeywordFromJson(jsonString);

import 'dart:convert';

List<ModelMostJobSearchedKeyword> modelMostJobSearchedKeywordFromJson(String str) => List<ModelMostJobSearchedKeyword>.from(json.decode(str).map((x) => ModelMostJobSearchedKeyword.fromJson(x)));

String modelMostJobSearchedKeywordToJson(List<ModelMostJobSearchedKeyword> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelMostJobSearchedKeyword {
  ModelMostJobSearchedKeyword({
    this.jobOppId,
    this.keyword,
  });

  String? jobOppId;
  String? keyword;

  factory ModelMostJobSearchedKeyword.fromJson(Map<String, dynamic> json) => ModelMostJobSearchedKeyword(
    jobOppId: json["job_opp_id"],
    keyword: json["keyword"],
  );
  fromJson(Map<String, dynamic> json) => ModelMostJobSearchedKeyword(
    jobOppId: json["job_opp_id"],
    keyword: json["keyword"],
  );

  Map<String, dynamic> toJson() => {
    "job_opp_id": jobOppId,
    "keyword": keyword,
  };
}

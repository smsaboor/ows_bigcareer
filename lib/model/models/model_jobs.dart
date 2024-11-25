// To parse this JSON data, do
//
//     final jobs = jobsFromJson(jsonString);

import 'dart:convert';

List<ModelJobs> jobsFromJson(String str) => List<ModelJobs>.from(json.decode(str).map((x) => ModelJobs.fromJson(x)));

String jobsToJson(List<ModelJobs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelJobs {
  ModelJobs({
    this.id,
    this.title,
    this.image,
    this.details,
    this.postDate,
    this.vacancy,
    this.lastDate,
    this.likes,
    this.comments,
    this.header,
  });

  String? id;
  String? title;
  String? image;
  String? details;
  String? postDate;
  String? vacancy;
  String? lastDate;
  String? likes;
  String? comments;
  String? header;

  factory ModelJobs.fromJson(Map<String, dynamic> json) => ModelJobs(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    details: json["details"],
    postDate: json["postDate"],
    vacancy: json["vacancy"],
    lastDate: json["lastDate"],
    likes: json["likes"],
    comments: json["comments"],
    header: json["header"],
  );
  ModelJobs fromJson(Map<String, dynamic> json) => ModelJobs(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    details: json["details"],
    postDate: json["postDate"],
    vacancy: json["vacancy"],
    lastDate: json["lastDate"],
    likes: json["likes"],
    comments: json["comments"],
    header: json["header"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "details": details,
    "postDate": postDate,
    "vacancy": vacancy,
    "lastDate": lastDate,
    "likes": likes,
    "comments": comments,
    "header": header,
  };
}

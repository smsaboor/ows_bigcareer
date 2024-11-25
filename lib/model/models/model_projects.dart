// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

List<ModelProjects> projectsFromJson(String str) => List<ModelProjects>.from(json.decode(str).map((x) => ModelProjects.fromJson(x)));

String projectsToJson(List<ModelProjects> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProjects {
  ModelProjects({
    this.id,
    this.title,
    this.amount,
    this.currency,
    this.paymentMode,
    this.bids,
    this.details,
    this.skills,
    this.time,
  });

  String? id;
  String? title;
  String? amount;
  String? currency;
  String? paymentMode;
  String? bids;
  String? details;
  String? skills;
  String? time;


  factory ModelProjects.fromJson(Map<String, dynamic> json) => ModelProjects(
    id: json["id"],
    title: json["title"],
    amount: json["amount"],
    currency: json["currency"],
    paymentMode: json["paymentMode"],
    bids: json["bids"],
    details: json["details"],
    skills: json["skills"],
    time: json["time"],
  );


  ModelProjects fromJson(Map<String, dynamic> json) => ModelProjects(
    id: json["id"],
    title: json["title"],
    amount: json["amount"],
    currency: json["currency"],
    paymentMode: json["paymentMode"],
    bids: json["bids"],
    details: json["details"],
    skills: json["skills"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "currency": currency,
    "paymentMode": paymentMode,
    "bids": bids,
    "details": details,
    "skills": skills,
    "time": time,
  };
}

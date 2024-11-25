// To parse this JSON data, do
//
//     final modelDisplayAllProjects = modelDisplayAllProjectsFromJson(jsonString);

import 'dart:convert';

List<ModelDisplayAllProjects> modelDisplayAllProjectsFromJson(String str) =>
    List<ModelDisplayAllProjects>.from(
        json.decode(str).map((x) => ModelDisplayAllProjects.fromJson(x)));

String modelDisplayAllProjectsToJson(List<ModelDisplayAllProjects> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDisplayAllProjects {
  ModelDisplayAllProjects({
    this.response,
    this.userId,
    this.id,
    this.title,
    this.details,
    this.image1,
    this.image2,
    this.image3,
    this.amount,
    this.currency,
    this.paymentMode,
    this.skills,
  });

  String? response;
  String? userId;
  String? id;
  String? title;
  String? details;
  String? image1;
  String? image2;
  String? image3;
  String? amount;
  String? currency;
  String? paymentMode;
  String? skills;

  factory ModelDisplayAllProjects.fromJson(Map<String, dynamic> json) =>
      ModelDisplayAllProjects(
        response: json["response"],
        userId: json["user_id"],
        id: json["id"],
        title: json["title"],
        details: json["details"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        amount: json["amount"],
        currency: json["currency"],
        paymentMode: json["paymentMode"],
        skills: json["skills"],
      );

  fromJson(Map<String, dynamic> json) => ModelDisplayAllProjects(
        response: json["response"],
        userId: json["user_id"],
        id: json["id"],
        title: json["title"],
        details: json["details"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        amount: json["amount"],
        currency: json["currency"],
        paymentMode: json["paymentMode"],
        skills: json["skills"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "user_id": userId,
        "id": id,
        "title": title,
        "details": details,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "amount": amount,
        "currency": currency,
        "paymentMode": paymentMode,
        "skills": skills,
      };
}

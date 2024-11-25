// To parse this JSON data, do
//
//     final freelancers = freelancersFromJson(jsonString);

import 'dart:convert';

List<ModelFreelancers> freelancersFromJson(String str) => List<ModelFreelancers>.from(json.decode(str).map((x) => ModelFreelancers.fromJson(x)));

String freelancersToJson(List<ModelFreelancers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFreelancers {
  ModelFreelancers({
    this.id,
    this.f_id,
    this.name,
    this.image,
    this.title,
    this.about,
    this.amount,
    this.currency,
    this.paymentMode,
    this.skills,
    this.country,
  });

  String? id;
  String? f_id;
  String? name;
  String? image;
  String? title;
  String? about;
  String? amount;
  String? currency;
  String? paymentMode;
  String? skills;
  String? country;

  factory ModelFreelancers.fromJson(Map<String, dynamic> json) => ModelFreelancers(
    id: json["id"],
    f_id: json["f_id"],
    name: json["name"],
    image: json["image"],
    title: json["title"],
    about: json["about"],
    amount: json["amount"],
    currency: json["currency"],
    paymentMode: json["paymentMode"],
    skills: json["skills"],
    country: json["country"],
  );
  ModelFreelancers fromJson(Map<String, dynamic> json) => ModelFreelancers(
    id: json["id"],
    f_id: json["f_id"],
    name: json["name"],
    image: json["image"],
    title: json["title"],
    about: json["about"],
    amount: json["amount"],
    currency: json["currency"],
    paymentMode: json["paymentMode"],
    skills: json["skills"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "f_id": f_id,
    "name": name,
    "image": image,
    "title": title,
    "about": about,
    "amount": amount,
    "currency": currency,
    "paymentMode": paymentMode,
    "skills": skills,
    "country": country,
  };
}

// To parse this JSON data, do
//
//     final modelStates = modelStatesFromJson(jsonString);

import 'dart:convert';

List<ModelStates> modelStatesFromJson(String str) => List<ModelStates>.from(json.decode(str).map((x) => ModelStates.fromJson(x)));

String modelStatesToJson(List<ModelStates> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelStates {
  ModelStates({
    this.id,
    this.statename,
  });

  String? id;
  String? statename;

  factory ModelStates.fromJson(Map<String, dynamic> json) => ModelStates(
    id: json["id"],
    statename: json["statename"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "statename": statename,
  };
}


class StatesWithCities {
  String? state;
  String? id;
  List<Cities>? cities;

  StatesWithCities({this.state, this.id, this.cities});

  StatesWithCities.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    id = json['id'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['id'] = this.id;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? city;
  Cities({this.city});

  Cities.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    return data;
  }
}
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

AdminBlockModel postFromJson(String str) => AdminBlockModel.fromJson(json.decode(str));

String postToJson(AdminBlockModel data) => json.encode(data.toJson());

class AdminBlockModel {
  AdminBlockModel({
    this.title,
    this.imgUrl,
    this.id,
    this.order = 0,
  });

  final String? title;
  final String? imgUrl;
  final String? id;
  final int order;

  AdminBlockModel copyWith({
    String? title,
    String? imgUrl,
    String? id,
    int order = 0,
  }) =>
      AdminBlockModel(
        title: title ?? this.title,
        imgUrl: imgUrl ?? this.imgUrl,
        id: id ?? this.id,
        order: order,
      );

  factory AdminBlockModel.fromJson(Map<String, dynamic> json) => AdminBlockModel(
        title: json["title"],
        imgUrl: json["imgUrl"],
        id: json["id"],
        order: json["order"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imgUrl": imgUrl,
        "id": id,
        "order": order,
      };
}

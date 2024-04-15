// To parse this JSON data, do
//
//     final fieldItemValueModel = fieldItemValueModelFromJson(jsonString);

import 'dart:convert';

FieldItemValueModel fieldItemValueModelFromJson(String str) => FieldItemValueModel.fromJson(json.decode(str));

String fieldItemValueModelToJson(FieldItemValueModel data) => json.encode(data.toJson());

class FieldItemValueModel {
  final String? value;
  final String? text;

  FieldItemValueModel({
    this.value,
    this.text,
  });

  FieldItemValueModel copyWith({
    String? value,
    String? text,
  }) =>
      FieldItemValueModel(
        value: value ?? this.value,
        text: text ?? this.text,
      );

  factory FieldItemValueModel.fromJson(Map<String, dynamic> json) => FieldItemValueModel(
        value: json["Value"].toString(),
        text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "Value": value,
        "Text": text,
      };
}

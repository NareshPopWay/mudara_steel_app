// To parse this JSON data, do
//
//     final bookinSucceessModel = bookinSucceessModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

SuccessModel succeessModelFromJson(String str) => SuccessModel.fromJson(json.decode(str));

String succeessModelToJson(SuccessModel data) => json.encode(data.toJson());

class SuccessModel {
  int msgType;
  String message;


  SuccessModel({
    required this.msgType,
    required this.message,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
    msgType: json["MsgType"]??0,
    message: json["Message"]??'',
  );

  Map<String, dynamic> toJson() => {
    "MsgType": msgType,
    "Message": message,
  };
}

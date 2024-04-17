// To parse this JSON data, do
//
//     final jobAllocationByIdModel = jobAllocationByIdModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JobAllocationByIdModel jobAllocationByIdModelFromJson(String str) => JobAllocationByIdModel.fromJson(json.decode(str));

String jobAllocationByIdModelToJson(JobAllocationByIdModel data) => json.encode(data.toJson());

class JobAllocationByIdModel {
  int jobAllocationId;
  int jobId;
  int jobAllocationTypeId;
  int jobBidId;
  int vendorId;
  double cost;
  String remark;
  dynamic isActive;
  dynamic createdOn;
  dynamic createdBy;
  dynamic createdUserTypeId;
  dynamic modifiedOn;
  dynamic modifiedBy;
  dynamic modifiedUserTypeId;
  dynamic isDelete;
  dynamic deletedOn;
  dynamic deletedBy;
  dynamic deletedUserTypeId;
  dynamic jobName;
  dynamic vendorName;

  JobAllocationByIdModel({
    required this.jobAllocationId,
    required this.jobId,
    required this.jobAllocationTypeId,
    required this.jobBidId,
    required this.vendorId,
    required this.cost,
    required this.remark,
    required this.isActive,
    required this.createdOn,
    required this.createdBy,
    required this.createdUserTypeId,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedUserTypeId,
    required this.isDelete,
    required this.deletedOn,
    required this.deletedBy,
    required this.deletedUserTypeId,
    required this.jobName,
    required this.vendorName,
  });

  factory JobAllocationByIdModel.fromJson(Map<String, dynamic> json) => JobAllocationByIdModel(
    jobAllocationId: json["JobAllocationID"],
    jobId: json["JobID"],
    jobAllocationTypeId: json["JobAllocationTypeID"],
    jobBidId: json["JobBidID"],
    vendorId: json["VendorID"],
    cost: json["Cost"],
    remark: json["Remark"],
    isActive: json["IsActive"],
    createdOn: json["CreatedOn"],
    createdBy: json["CreatedBY"],
    createdUserTypeId: json["CreatedUserTypeID"],
    modifiedOn: json["ModifiedOn"],
    modifiedBy: json["ModifiedBY"],
    modifiedUserTypeId: json["ModifiedUserTypeID"],
    isDelete: json["IsDelete"],
    deletedOn: json["DeletedOn"],
    deletedBy: json["DeletedBy"],
    deletedUserTypeId: json["DeletedUserTypeID"],
    jobName: json["JobName"],
    vendorName: json["VendorName"],
  );

  Map<String, dynamic> toJson() => {
    "JobAllocationID": jobAllocationId,
    "JobID": jobId,
    "JobAllocationTypeID": jobAllocationTypeId,
    "JobBidID": jobBidId,
    "VendorID": vendorId,
    "Cost": cost,
    "Remark": remark,
    "IsActive": isActive,
    "CreatedOn": createdOn,
    "CreatedBY": createdBy,
    "CreatedUserTypeID": createdUserTypeId,
    "ModifiedOn": modifiedOn,
    "ModifiedBY": modifiedBy,
    "ModifiedUserTypeID": modifiedUserTypeId,
    "IsDelete": isDelete,
    "DeletedOn": deletedOn,
    "DeletedBy": deletedBy,
    "DeletedUserTypeID": deletedUserTypeId,
    "JobName": jobName,
    "VendorName": vendorName,
  };
}

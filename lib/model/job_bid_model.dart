// To parse this JSON data, do
//
//     final jobBidModel = jobBidModelFromJson(jsonString);

import 'dart:convert';

List<JobBidModel> jobBidModelFromJson(String str) => List<JobBidModel>.from(json.decode(str).map((x) => JobBidModel.fromJson(x)));

String jobBidModelToJson(List<JobBidModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobBidModel {
  int? totalRows;
  int? jobBidId;
  int? jobId;
  int? jobBidTypeId;
  int? vendorId;
  double? cost;
  dynamic remark;
  dynamic isActive;
  DateTime? createdOn;
  int? createdBy;
  int? createdUserTypeId;
  DateTime? modifiedOn;
  int? modifiedBy;
  int? modifiedUserTypeId;
  dynamic isDelete;
  dynamic deletedOn;
  dynamic deletedBy;
  dynamic deletedUserTypeId;
  String? vendorName;
  String? jobName;
  int? jobTypeId;
  int? jobStatusId;
  String? jobStatus;
  String? jobType;

  JobBidModel({
    this.totalRows,
    this.jobBidId,
    this.jobId,
    this.jobBidTypeId,
    this.vendorId,
    this.cost,
    this.remark,
    this.isActive,
    this.createdOn,
    this.createdBy,
    this.createdUserTypeId,
    this.modifiedOn,
    this.modifiedBy,
    this.modifiedUserTypeId,
    this.isDelete,
    this.deletedOn,
    this.deletedBy,
    this.deletedUserTypeId,
    this.vendorName,
    this.jobName,
    this.jobTypeId,
    this.jobStatusId,
    this.jobStatus,
    this.jobType,
  });

  factory JobBidModel.fromJson(Map<String, dynamic> json) => JobBidModel(
    totalRows: json["TotalRows"],
    jobBidId: json["JobBidID"],
    jobId: json["JobID"],
    jobBidTypeId: json["JobBidTypeID"],
    vendorId: json["VendorID"],
    cost: json["Cost"]?.toDouble(),
    remark: json["Remark"],
    isActive: json["IsActive"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBY"],
    createdUserTypeId: json["CreatedUserTypeID"],
    modifiedOn: json["ModifiedOn"] == null ? null : DateTime.parse(json["ModifiedOn"]),
    modifiedBy: json["ModifiedBY"],
    modifiedUserTypeId: json["ModifiedUserTypeID"],
    isDelete: json["IsDelete"],
    deletedOn: json["DeletedOn"],
    deletedBy: json["DeletedBy"],
    deletedUserTypeId: json["DeletedUserTypeID"],
    vendorName: json["VendorName"],
    jobName: json["JobName"],
    jobTypeId: json["JobTypeID"],
    jobStatusId: json["JobStatusID"],
    jobStatus: json["JobStatus"],
    jobType: json["JobType"],
  );

  Map<String, dynamic> toJson() => {
    "TotalRows": totalRows,
    "JobBidID": jobBidId,
    "JobID": jobId,
    "JobBidTypeID": jobBidTypeId,
    "VendorID": vendorId,
    "Cost": cost,
    "Remark": remark,
    "IsActive": isActive,
    "CreatedOn": createdOn,
    "CreatedBY": createdBy,
    "CreatedUserTypeID": createdUserTypeId,
    "ModifiedOn": modifiedOn?.toIso8601String(),
    "ModifiedBY": modifiedBy,
    "ModifiedUserTypeID": modifiedUserTypeId,
    "IsDelete": isDelete,
    "DeletedOn": deletedOn,
    "DeletedBy": deletedBy,
    "DeletedUserTypeID": deletedUserTypeId,
    "VendorName": vendorName,
    "JobName": jobName,
    "JobTypeID": jobTypeId,
    "JobStatusID": jobStatusId,
    "JobStatus": jobStatus,
    "JobType": jobType,
  };

}

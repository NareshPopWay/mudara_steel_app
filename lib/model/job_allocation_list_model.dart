// To parse this JSON data, do
//
//     final jobAllocationListModel = jobAllocationListModelFromJson(jsonString);

import 'dart:convert';

List<JobAllocationListModel> jobAllocationListModelFromJson(String str) => List<JobAllocationListModel>.from(json.decode(str).map((x) => JobAllocationListModel.fromJson(x)));

String jobAllocationListModelToJson(List<JobAllocationListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobAllocationListModel {
  int? totalRows;
  int? jobAllocationId;
  int? jobId;
  int? jobAllocationTypeId;
  int? jobBidId;
  int? vendorId;
  double? cost;
  dynamic remark;
  dynamic isActive;
  DateTime? createdOn;
  int? createdBy;
  int? createdUserTypeId;
  dynamic modifiedOn;
  dynamic modifiedBy;
  dynamic modifiedUserTypeId;
  dynamic isDelete;
  dynamic deletedOn;
  dynamic deletedBy;
  dynamic deletedUserTypeId;
  String? jobName;
  String? vendorName;

  JobAllocationListModel({
    this.totalRows,
    this.jobAllocationId,
    this.jobId,
    this.jobAllocationTypeId,
    this.jobBidId,
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
    this.jobName,
    this.vendorName,
  });

  factory JobAllocationListModel.fromJson(Map<String, dynamic> json) => JobAllocationListModel(
    totalRows: json["TotalRows"],
    jobAllocationId: json["JobAllocationID"],
    jobId: json["JobID"],
    jobAllocationTypeId: json["JobAllocationTypeID"],
    jobBidId: json["JobBidID"],
    vendorId: json["VendorID"],
    cost: json["Cost"]??0,
    remark: json["Remark"],
    isActive: json["IsActive"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
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
    "TotalRows": totalRows,
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

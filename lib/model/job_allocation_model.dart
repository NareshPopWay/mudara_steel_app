import 'dart:convert';

class JobAllocationModel {
  int? jobAllocationId;
  int? jobId;
  int? jobAllocationTypeId;
  int? jobBidId;
  int? vendorId;
  double? cost;
  String? remark;
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

  JobAllocationModel({
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

  factory JobAllocationModel.fromJson(Map<String, dynamic> json) => JobAllocationModel(
    jobAllocationId: json["JobAllocationID"],
    jobId: json["JobID"],
    jobAllocationTypeId: json["JobAllocationTypeID"],
    jobBidId: json["JobBidID"],
    vendorId: json["VendorID"],
    cost: json["Cost"]??0.0,
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

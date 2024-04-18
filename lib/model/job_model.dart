// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';


class JobModel {
  int? jobId;
  int? companyId;
  String? jobName;
  int? jobStatusId;
  int? fromLocationId;
  String? fromLocation;
  int? toLocationId;
  String? toLocation;
  DateTime? deliveryDate;
  int? jobTypeId;
  bool? isTruck;
  dynamic weight;
  String? weightUnit;
  String? column1;
  String? column2;
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
  dynamic jobStatus;
  dynamic jobType;

  JobModel({
     this.jobId,
     this.companyId,
     this.jobName,
     this.jobStatusId,
     this.fromLocationId,
     this.fromLocation,
     this.toLocationId,
     this.toLocation,
     this.deliveryDate,
     this.jobTypeId,
     this.isTruck,
     this.weight,
     this.weightUnit,
     this.column1,
     this.column2,
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
     this.jobStatus,
     this.jobType,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    jobId: json["JobID"],
    companyId: json["CompanyID"],
    jobName: json["JobName"],
    jobStatusId: json["JobStatusID"],
    fromLocationId: json["FromLocationID"],
    fromLocation: json["FromLocation"],
    toLocationId: json["ToLocationID"],
    toLocation: json["ToLocation"],
    deliveryDate:  json["DeliveryDate"] == null ? null : DateTime.parse(json["DeliveryDate"]),
    jobTypeId: json["JobTypeID"],
    isTruck: json["IsTruck"],
    weight: json["Weight"]??"",
    weightUnit: json["WeightUnit"],
    column1: json["Column1"],
    column2: json["Column2"],
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
    jobStatus: json["JobStatus"],
    jobType: json["JobType"],
  );

  Map<String, dynamic> toJson() => {
    "JobID": jobId,
    "CompanyID": companyId,
    "JobName": jobName,
    "JobStatusID": jobStatusId,
    "FromLocationID": fromLocationId,
    "FromLocation": fromLocation,
    "ToLocationID": toLocationId,
    "ToLocation": toLocation,
    "DeliveryDate": deliveryDate,
    "JobTypeID": jobTypeId,
    "IsTruck": isTruck,
    "Weight": weight,
    "WeightUnit": weightUnit,
    "Column1": column1,
    "Column2": column2,
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
    "JobStatus": jobStatus,
    "JobType": jobType,
  };
}

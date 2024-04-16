// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<JobListModel> jobListModelFromJson(String str) => List<JobListModel>.from(json.decode(str).map((x) => JobListModel.fromJson(x)));

String jobListModelToJson(List<JobListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobListModel {
  int? totalRows;
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
  dynamic weightUnit;
  String? column1;
  dynamic column2;
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
  String? jobStatus;
  String? jobType;

  JobListModel({
     this.totalRows,
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

  JobListModel copyWith({
    int? totalRows,
    int? jobId,
    int? companyId,
    String? jobName,
    int? jobStatusId,
    int? fromLocationId,
    String? fromLocation,
    int? toLocationId,
    String? toLocation,
    DateTime? deliveryDate,
    int? jobTypeId,
    bool? isTruck,
    dynamic weight,
    dynamic weightUnit,
    String? column1,
    dynamic column2,
    dynamic remark,
    dynamic isActive,
    DateTime? createdOn,
    int? createdBy,
    int? createdUserTypeId,
    dynamic modifiedOn,
    dynamic modifiedBy,
    dynamic modifiedUserTypeId,
    dynamic isDelete,
    dynamic deletedOn,
    dynamic deletedBy,
    dynamic deletedUserTypeId,
    String? jobStatus,
    String? jobType,
  }) =>
      JobListModel(
        totalRows: totalRows ?? this.totalRows,
        jobId: jobId ?? this.jobId,
        companyId: companyId ?? this.companyId,
        jobName: jobName ?? this.jobName,
        jobStatusId: jobStatusId ?? this.jobStatusId,
        fromLocationId: fromLocationId ?? this.fromLocationId,
        fromLocation: fromLocation ?? this.fromLocation,
        toLocationId: toLocationId ?? this.toLocationId,
        toLocation: toLocation ?? this.toLocation,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        jobTypeId: jobTypeId ?? this.jobTypeId,
        isTruck: isTruck ?? this.isTruck,
        weight: weight ?? this.weight,
        weightUnit: weightUnit ?? this.weightUnit,
        column1: column1 ?? this.column1,
        column2: column2 ?? this.column2,
        remark: remark ?? this.remark,
        isActive: isActive ?? this.isActive,
        createdOn: createdOn ?? this.createdOn,
        createdBy: createdBy ?? this.createdBy,
        createdUserTypeId: createdUserTypeId ?? this.createdUserTypeId,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        modifiedUserTypeId: modifiedUserTypeId ?? this.modifiedUserTypeId,
        isDelete: isDelete ?? this.isDelete,
        deletedOn: deletedOn ?? this.deletedOn,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedUserTypeId: deletedUserTypeId ?? this.deletedUserTypeId,
        jobStatus: jobStatus ?? this.jobStatus,
        jobType: jobType ?? this.jobType,
      );

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
    totalRows: json["TotalRows"],
    jobId: json["JobID"],
    companyId: json["CompanyID"],
    jobName: json["JobName"],
    jobStatusId: json["JobStatusID"],
    fromLocationId: json["FromLocationID"],
    fromLocation: json["FromLocation"],
    toLocationId: json["ToLocationID"],
    toLocation: json["ToLocation"],
    deliveryDate: json["DeliveryDate"] == null ? null : DateTime.parse(json["DeliveryDate"]),
    jobTypeId: json["JobTypeID"],
    isTruck: json["IsTruck"],
    weight: json["Weight"],
    weightUnit: json["WeightUnit"],
    column1: json["Column1"],
    column2: json["Column2"],
    remark: json["Remark"],
    isActive: json["IsActive"],
    createdOn:json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]) ,
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
    "TotalRows": totalRows,
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

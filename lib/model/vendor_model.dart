// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VendorModel vendorModelFromJson(String str) => VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  int? vendorId;
  // dynamic code;
  // dynamic firstName;
  // dynamic middleName;
  // dynamic lastName;
  String? vendorName;
  String? email;
  String? phone;
  // dynamic phoneWithDialCode;
  // dynamic fax;
  // dynamic website;
  // dynamic username;
  String? password;
  dynamic companyName;
  String? address;
  // int? pincode;
  // int? countryId;
  // int? stateId;
  // int? cityId;
  // dynamic bankName;
  // dynamic accountNumber;
  // dynamic ifcsCode;
  // dynamic panNo;
  // dynamic gstNo;
  // String? remark;
  // dynamic attachmentPath;
  // int? companyId;
  // dynamic companyPhone;
  // dynamic address2;
  // dynamic accountHolderName;
  // dynamic accountType;
  // dynamic accountBranch;
  // dynamic tinNo;
  // dynamic description;
  // dynamic isActive;
  // bool? isApproved;
  // int? vendorTypeId;
  String? driverName;
  String? driverAge;
  dynamic aadharCardUpload;
  // dynamic file;
  String? driverLicenseNumber;
  String? vehicleInsuranceNumber;
  // dynamic createdOn;
  // dynamic createdBy;
  // dynamic createdUserTypeId;
  // dynamic modifiedOn;
  // dynamic modifiedBy;
  // dynamic modifiedUserTypeId;
  // dynamic isDelete;
  // dynamic deletedOn;
  // dynamic deletedBy;
  // dynamic deletedUserTypeId;

  VendorModel({
     this.vendorId,
     // this.code,
     // this.firstName,
     // this.middleName,
     // this.lastName,
     this.vendorName,
     this.email,
     this.phone,
     // this.phoneWithDialCode,
     // this.fax,
     // this.website,
     // this.username,
     this.password,
     this.companyName,
     this.address,
     // this.pincode,
     // this.countryId,
     // this.stateId,
     // this.cityId,
     // this.bankName,
     // this.accountNumber,
     // this.ifcsCode,
     // this.panNo,
     // this.gstNo,
     // this.remark,
     // this.attachmentPath,
     // this.companyId,
     // this.companyPhone,
     // this.address2,
     // this.accountHolderName,
     // this.accountType,
     // this.accountBranch,
     // this.tinNo,
     // this.description,
     // this.isActive,
     // this.isApproved,
     // this.vendorTypeId,
     this.driverName,
     this.driverAge,
     this.aadharCardUpload,
     // this.file,
     this.driverLicenseNumber,
     this.vehicleInsuranceNumber,
     // this.createdOn,
     // this.createdBy,
     // this.createdUserTypeId,
     // this.modifiedOn,
     // this.modifiedBy,
     // this.modifiedUserTypeId,
     // this.isDelete,
     // this.deletedOn,
     // this.deletedBy,
     // this.deletedUserTypeId,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    vendorId: json["VendorID"],
    // code: json["Code"],
    // firstName: json["FirstName"],
    // middleName: json["MiddleName"],
    // lastName: json["LastName"],
    vendorName: json["VendorName"]??"",
    email: json["Email"]??"",
    phone: json["Phone"]??"",
    // phoneWithDialCode: json["PhoneWithDialCode"],
    // fax: json["Fax"],
    // website: json["Website"],
    // username: json["Username"],
    password: json["Password"]??"",
    companyName: json["CompanyName"]??"",
    address: json["Address"]??"",
    // pincode: json["Pincode"],
    // countryId: json["CountryID"],
    // stateId: json["StateID"],
    // cityId: json["CityID"],
    // bankName: json["BankName"],
    // accountNumber: json["AccountNumber"],
    // ifcsCode: json["IFCSCode"],
    // panNo: json["PAN_No"],
    // gstNo: json["GST_No"],
    // remark: json["Remark"],
    // attachmentPath: json["AttachmentPath"],
    // companyId: json["CompanyID"],
    // companyPhone: json["CompanyPhone"],
    // address2: json["Address2"],
    // accountHolderName: json["AccountHolderName"],
    // accountType: json["AccountType"],
    // accountBranch: json["AccountBranch"],
    // tinNo: json["TIN_No"],
    // description: json["Description"],
    // isActive: json["IsActive"],
    // isApproved: json["IsApproved"],
    // vendorTypeId: json["VendorTypeID"],
    driverName: json["DriverName"]??"",
    driverAge: json["DriverAge"]??"",
    aadharCardUpload: json["AadharCardUpload"],
    // file: json["file"],
    driverLicenseNumber: json["DriverLicenseNumber"]??"",
    vehicleInsuranceNumber: json["VehicleInsuranceNumber"]??"",
    // createdOn: json["CreatedOn"],
    // createdBy: json["CreatedBY"],
    // createdUserTypeId: json["CreatedUserTypeID"],
    // modifiedOn: json["ModifiedOn"],
    // modifiedBy: json["ModifiedBY"],
    // modifiedUserTypeId: json["ModifiedUserTypeID"],
    // isDelete: json["IsDelete"],
    // deletedOn: json["DeletedOn"],
    // deletedBy: json["DeletedBy"],
    // deletedUserTypeId: json["DeletedUserTypeID"],
  );

  Map<String, dynamic> toJson() => {
    "VendorID": vendorId,
    // "Code": code,
    // "FirstName": firstName,
    // "MiddleName": middleName,
    // "LastName": lastName,
    "VendorName": vendorName,
    "Email": email,
    "Phone": phone,
    // "PhoneWithDialCode": phoneWithDialCode,
    // "Fax": fax,
    // "Website": website,
    // "Username": username,
    "Password": password,
    "CompanyName": companyName,
    "Address": address,
    // "Pincode": pincode,
    // "CountryID": countryId,
    // "StateID": stateId,
    // "CityID": cityId,
    // "BankName": bankName,
    // "AccountNumber": accountNumber,
    // "IFCSCode": ifcsCode,
    // "PAN_No": panNo,
    // "GST_No": gstNo,
    // "Remark": remark,
    // "AttachmentPath": attachmentPath,
    // "CompanyID": companyId,
    // "CompanyPhone": companyPhone,
    // "Address2": address2,
    // "AccountHolderName": accountHolderName,
    // "AccountType": accountType,
    // "AccountBranch": accountBranch,
    // "TIN_No": tinNo,
    // "Description": description,
    // "IsActive": isActive,
    // "IsApproved": isApproved,
    // "VendorTypeID": vendorTypeId,
    "DriverName": driverName,
    "DriverAge": driverAge,
    "AadharCardUpload": aadharCardUpload,
    // "file": file,
    "DriverLicenseNumber": driverLicenseNumber,
    "VehicleInsuranceNumber": vehicleInsuranceNumber,
    // "CreatedOn": createdOn,
    // "CreatedBY": createdBy,
    // "CreatedUserTypeID": createdUserTypeId,
    // "ModifiedOn": modifiedOn,
    // "ModifiedBY": modifiedBy,
    // "ModifiedUserTypeID": modifiedUserTypeId,
    // "IsDelete": isDelete,
    // "DeletedOn": deletedOn,
    // "DeletedBy": deletedBy,
    // "DeletedUserTypeID": deletedUserTypeId,
  };
}

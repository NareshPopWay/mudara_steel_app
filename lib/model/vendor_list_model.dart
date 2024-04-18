// To parse this JSON data, do
//
//     final vendorListModel = vendorListModelFromJson(jsonString);

import 'dart:convert';

List<VendorListModel> vendorListModelFromJson(String str) => List<VendorListModel>.from(json.decode(str).map((x) => VendorListModel.fromJson(x)));

String vendorListModelToJson(List<VendorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorListModel {
  int? totalRows;
  int? vendorId;
  int? companyId;
  String? code;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  String? email;
  String? phone;
  dynamic fax;
  dynamic website;
  dynamic username;
  String? password;
  dynamic companyName;
  dynamic companyPhone;
  String? address;
  dynamic address2;
  int? pincode;
  int? countryId;
  int? stateId;
  int? cityId;
  dynamic bankName;
  dynamic accountNumber;
  dynamic accountHolderName;
  dynamic accountType;
  dynamic accountBranch;
  dynamic tinNo;
  dynamic description;
  dynamic ifcsCode;
  dynamic panNo;
  dynamic gstNo;
  String? remark;
  dynamic attachmentPath;
  dynamic asofDate;
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
  String? venderName;
  dynamic vendorType;
  dynamic city;
  int? vendorTypeId;
  String? vendorName;
  String? driverName;
  String? driverAge;
  dynamic aadharCardUpload;
  String? driverLicenseNumber;
  String? vehicleInsuranceNumber;
  bool? isApproved;

  VendorListModel({
    this.totalRows,
    this.vendorId,
    this.companyId,
    this.code,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phone,
    this.fax,
    this.website,
    this.username,
    this.password,
    this.companyName,
    this.companyPhone,
    this.address,
    this.address2,
    this.pincode,
    this.countryId,
    this.stateId,
    this.cityId,
    this.bankName,
    this.accountNumber,
    this.accountHolderName,
    this.accountType,
    this.accountBranch,
    this.tinNo,
    this.description,
    this.ifcsCode,
    this.panNo,
    this.gstNo,
    this.remark,
    this.attachmentPath,
    this.asofDate,
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
    this.venderName,
    this.vendorType,
    this.city,
    this.vendorTypeId,
    this.vendorName,
    this.driverName,
    this.driverAge,
    this.aadharCardUpload,
    this.driverLicenseNumber,
    this.vehicleInsuranceNumber,
    this.isApproved,
  });

  factory VendorListModel.fromJson(Map<String, dynamic> json) => VendorListModel(
    totalRows: json["TotalRows"],
    vendorId: json["VendorID"],
    companyId: json["CompanyID"],
    code: json["Code"],
    firstName: json["FirstName"],
    middleName: json["MiddleName"],
    lastName: json["LastName"],
    email: json["Email"],
    phone: json["Phone"],
    fax: json["Fax"],
    website: json["Website"],
    username: json["Username"],
    password: json["Password"],
    companyName: json["CompanyName"],
    companyPhone: json["CompanyPhone"],
    address: json["Address"],
    address2: json["Address2"],
    pincode: json["Pincode"],
    countryId: json["CountryID"],
    stateId: json["StateID"],
    cityId: json["CityID"],
    bankName: json["BankName"],
    accountNumber: json["AccountNumber"],
    accountHolderName: json["AccountHolderName"],
    accountType: json["AccountType"],
    accountBranch: json["AccountBranch"],
    tinNo: json["TIN_No"],
    description: json["Description"],
    ifcsCode: json["IFCSCode"],
    panNo: json["PAN_No"],
    gstNo: json["GST_No"],
    remark: json["Remark"],
    attachmentPath: json["AttachmentPath"],
    asofDate: json["AsofDate"],
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
    venderName: json["VenderName"],
    vendorType: json["VendorType"],
    city: json["City"],
    vendorTypeId: json["VendorTypeID"],
    vendorName: json["VendorName"],
    driverName: json["DriverName"],
    driverAge: json["DriverAge"],
    aadharCardUpload: json["AadharCardUpload"],
    driverLicenseNumber: json["DriverLicenseNumber"],
    vehicleInsuranceNumber: json["VehicleInsuranceNumber"],
    isApproved: json["IsApproved"],
  );

  Map<String, dynamic> toJson() => {
    "TotalRows": totalRows,
    "VendorID": vendorId,
    "CompanyID": companyId,
    "Code": code,
    "FirstName": firstName,
    "MiddleName": middleName,
    "LastName": lastName,
    "Email": email,
    "Phone": phone,
    "Fax": fax,
    "Website": website,
    "Username": username,
    "Password": password,
    "CompanyName": companyName,
    "CompanyPhone": companyPhone,
    "Address": address,
    "Address2": address2,
    "Pincode": pincode,
    "CountryID": countryId,
    "StateID": stateId,
    "CityID": cityId,
    "BankName": bankName,
    "AccountNumber": accountNumber,
    "AccountHolderName": accountHolderName,
    "AccountType": accountType,
    "AccountBranch": accountBranch,
    "TIN_No": tinNo,
    "Description": description,
    "IFCSCode": ifcsCode,
    "PAN_No": panNo,
    "GST_No": gstNo,
    "Remark": remark,
    "AttachmentPath": attachmentPath,
    "AsofDate": asofDate,
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
    "VenderName": venderName,
    "VendorType": vendorType,
    "City": city,
    "VendorTypeID": vendorTypeId,
    "VendorName": vendorName,
    "DriverName": driverName,
    "DriverAge": driverAge,
    "AadharCardUpload": aadharCardUpload,
    "DriverLicenseNumber": driverLicenseNumber,
    "VehicleInsuranceNumber": vehicleInsuranceNumber,
    "IsApproved": isApproved,
  };
}

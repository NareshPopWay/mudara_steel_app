

// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/custom_exceptions.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_list_model.dart';
import 'package:mudara_steel_app/model/job_allocation_model.dart';
import 'package:mudara_steel_app/model/job_bid_model.dart';
import 'package:mudara_steel_app/model/job_list_model.dart';
import 'package:mudara_steel_app/model/job_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/model/vendor_list_model.dart';
import 'package:mudara_steel_app/model/vendor_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class APIProvider  {

  // final String imageUrl = "http://116.72.8.100:2202"; // ImageUrlLIVE
  final String imageUrl = "http://103.209.145.199:2202"; // client ImageUrlLIVE
  // final String imageUrl = "http://116.72.8.100:2525"; // ImageUrl Testing


  // final String baseUrl = "http://116.72.8.100:2203"; // Testing
  // final String baseUrl = "http://116.72.8.100:2202"; //  LIVE
  final String baseUrl = "http://103.209.145.199:2202"; // Client LIVE
  // final String baseUrl = "http://116.72.8.100:2525"; // Testing Url 2

  RxString userName = "".obs;
  RxString password = "".obs;
  RxString apiToken = "".obs;
  // String {{apiToken.value}} = Get.find<RootController>().token.value;
  // String userName = Get.find<RootController>().userName.value != "" ? Get.find<RootController>().userName.value : "AD";
  // String password = Get.find<RootController>().password.value != "" ? Get.find<RootController>().password.value : "furniture";


  String languageCode =  GetStorage().read('languageCode').toString() ?? "hi";
  RootController  rootController = Get.put(RootController());

  ///------------------------ Login -----------------------------------///


  Future<bool> login(context,{required userName, required password}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
    }
    var responseJson;
    try {
      log("$baseUrl/token");
      Map data ={
        "UserName": userName,
        "Password": password,
        "grant_type": "password",
      };
      log("$data");
      final response = await http.post(
        Uri.parse(
          "$baseUrl/token",
        ),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "UserName": userName,
          "Password": password,
          "grant_type": "password",
        },
      );
      // responseJson = _response(response);
      // log(responseJson['error']);
      // if (responseJson['error'] != null) {
      //   return false;
      // } else {
      //   {{apiToken.value}} = rootController.token.value;
      //   {{apiToken.value}} = responseJson['access_token'];
      //   await getProfileData();
      //   return true;
      // }
      responseJson = json.decode(response.body.toString());
      log('Token Response :- $responseJson');
      if(response.statusCode == 200){
        log('access_token :- ${responseJson['access_token']}');
        if (responseJson['access_token'] != null &&
            responseJson['access_token'] != "") {
          GetStorage().write(Constants.token, responseJson['access_token'].toString());
          GetStorage().write(Constants.userTypeID, responseJson['UserTypeID'].toString());
          APIProvider().updateFCMToken(context,userTypeID: responseJson['UserTypeID'].toString());
          if(responseJson['UserTypeID'].toString() == "1"){
            GetStorage().write(Constants.userName, responseJson['UserType'].toString());
          }else{
            await APIProvider().getVendorProfileData();
          }
          return true;
        }
        else {
          Ui.ErrorSnackBar(title:getTranslated(context, 'UnableToLogin')!,
              message:responseJson['error_description'].toString() == "Please Contact Admin For Approval." ? getTranslated(context, 'PleaseContactAdminForApproval')!
              :responseJson['error_description'].toString() == "Invalid Username or Password." ? getTranslated(context, 'InvalidUsernameOrPassword')!:
           '${responseJson['error_description']}');
          return false;
        }
      } else {
        Ui.ErrorSnackBar(title:getTranslated(context, 'UnableToLogin')!,message:responseJson['error_description'].toString() == "Please Contact Admin For Approval." ? getTranslated(context, 'PleaseContactAdminForApproval')!
            :responseJson['error_description'].toString() == "Invalid Username or Password." ? getTranslated(context, 'InvalidUsernameOrPassword')!:
        '${responseJson['error_description']}');
        return false;
      }
    } on SocketException {
      Ui.worningSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message:getTranslated(context, 'PleaseTryAgainLatter')!);
    } catch (e) {
      print("error ...login ...... $e");
    }
    return false;
  }

  Future<void> updateFCMToken(context,{userTypeID}) async {
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      var url;
      if(userTypeID == "1"){
        url = "/AdminApi/EmployeeAPI/UpdateFCMToken";
      }else{
        url="/VendorApi/VendorAPI/UpdateFCMToken";
      }

      String? firebaseToken;
      firebaseToken = await FirebaseMessaging.instance.getToken();
      log('FirebaseToken : $firebaseToken');
      Map body = {
        "FCMToken": firebaseToken.toString(),
      };
      log('$baseUrl$url');
      log(body.toString());

      final response = await http.get(
        Uri.parse('$baseUrl$url?FCMToken=$firebaseToken'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${apiToken.value}',
        },
      );
      responseJson = _response(response);
      log('updateFCMToken :- $responseJson');
    } on SocketException {
     Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
    } catch (e) {
      log("error ...updateFCMToken ...... $e");
    }
  }


///---------------------------- Vendor Reg ---------------------------------------////

  Future<SuccessModel> registerVendor(context,
      {required Map<String, String> data,
        String? path}) async {
    var responseJson;
    try {

      log("$baseUrl/api/CommanAPI/SaveVendor");
      log('$data');
      log('$path');
      var headers = {"Content-Type": "application/form-data"};

      var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrl/api/CommanAPI/SaveVendor"),
      );
      request.fields.addAll(data);
      // request.fields.addAll(jsonDecode(
      //   jsonEncode(body),
      // ));
      if (path != "" && path != null) {
        request.files.add(await http.MultipartFile.fromPath('AadharCardUpload', path));
      }
      request.headers.addAll(headers);

      var sendRequest = await request.send();
      var response = await http.Response.fromStream(sendRequest);
      responseJson = response.body.toString();
      log(responseJson);
      if(response.statusCode ==200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title:getTranslated(context, 'SomethingWentWrong')!);
      return SuccessModel.fromJson(Map());
    } catch (e) {
      log("error ...registerVendor ...... $e");
    }
    return SuccessModel.fromJson(Map());
  }

  Future<SuccessModel> updateVendor(context,
      {required Map<String, String> data,
        String? path}) async {
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      log("$baseUrl/VendorApi/VendorAPI/SaveVendor");
      log('$data');
      log('$path');
      var headers = {
        "Content-Type": "application/form-data",
        'Authorization': 'Bearer ${apiToken.value}'
      };

      var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrl/VendorApi/VendorAPI/SaveVendor"),
      );
      request.fields.addAll(data);
      // request.fields.addAll(jsonDecode(
      //   jsonEncode(body),
      // ));
      if (path != "" && path != null) {
        request.files.add(await http.MultipartFile.fromPath('AadharCardUpload', path));
      }
      request.headers.addAll(headers);

      var sendRequest = await request.send();
      var response = await http.Response.fromStream(sendRequest);
      responseJson = response.body.toString();
      log(responseJson);
      if(response.statusCode ==200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title:getTranslated(context, 'SomethingWentWrong')!);
      return SuccessModel.fromJson(Map());
    } catch (e) {
      log("error ...registerVendor ...... $e");
    }
    return SuccessModel.fromJson(Map());
  }

  Future<VendorModel> getVendorProfileData() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/VendorApi/VendorAPI/GetDataByVendorID");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/VendorApi/VendorAPI/GetDataByVendorID",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = jsonDecode(response.body.toString());
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          log(responseJson['VendorName'].toString());
          GetStorage().write(Constants.userName,responseJson['VendorName'].toString());
          return VendorModel.fromJson(responseJson);
        } else {
          return VendorModel.fromJson(responseJson);
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title:  languageCode == "hi" ? "कुछ गलत हो गया!" :'Something went wrong ',message:languageCode == "hi" ? "कृपया करके थोडी देर बाद प्रयाश करे" :'Please try again latter');
      return VendorModel.fromJson(Map());
    } catch (e) {
      print("error ...getVendorProfileData ...... $e");
    }
    return VendorModel.fromJson(responseJson);
  }

///------------------------------ Get Job -----------------------------------///
  Future<List<JobListModel>> getJobList({
    pageNumber,
    rowsOfPage,
    orderByName,
    searchVal,
    fromDate,
    toDate,
    sortDirection,
    jobType,
    jobStatusId,
    tempStatusID,
    jobId,
    fromLocation,
    toLocation,
    userTypeID
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<JobListModel> list = [];

    if (jobType == null || jobType == "") {
      jobType = "0";
    }
    if (jobStatusId == null || jobStatusId == "") {
      jobStatusId = "0";
    }
    if (jobId == null || jobId == "") {
      jobId = "0";
    }
    if (tempStatusID == null || tempStatusID == "") {
      tempStatusID = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      var url;
      if(userTypeID == "1"){
        url = "/AdminAPI/JobAPI/GetList";
      }else{
        url="/VendorApi/VendorAPI/GetJobList";
      }

      log("$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&SearchVal=$searchVal&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobTypeID=$jobType&TempStatusID=$tempStatusID&FromLocation=$fromLocation&ToLocation=$toLocation");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&SearchVal=$searchVal&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobTypeID=$jobType&TempStatusID=$tempStatusID&FromLocation=$fromLocation&ToLocation=$toLocation",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson["data"].toString());

      for (int i = 0; i < responseJson['data'].length; i++) {
        list.add(JobListModel.fromJson(responseJson['data'][i]));
      }
    }catch (e) {
      print("error ...getLeadList ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobNameList(userTypeID) async {
    // bool isInternet = await Constants.isInternetAvail();
    // if (!isInternet) {
    //   Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    // }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      var url;
      if(userTypeID == "1"){
        url = "/AdminAPI/JobAPI/GetJobList";
      }else{
        url="/VendorApi/VendorAPI/GetAllJobList";
      }
      log("$baseUrl$url");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobStatusList(userTypeID) async {
    // bool isInternet = await Constants.isInternetAvail();
    // if (!isInternet) {
    //   Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    // }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      var url;
      if(userTypeID == "1"){
        url = "/AdminAPI/JobAPI/GetJobStatusList";
      }else{
        url="/VendorApi/VendorAPI/GetJobStatusList";
      }
      log("$baseUrl$url");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobTypeList(userTypeID) async {
    // bool isInternet = await Constants.isInternetAvail();
    // if (!isInternet) {
    //   Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    // }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {


      var url;
      if(userTypeID == "1"){
        url = "/AdminAPI/JobAPI/GetJobTypeList";
      }else{
        url="/VendorApi/VendorAPI/GetJobTypeList";
      }
      log("$baseUrl$url");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    }catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }


  Future<SuccessModel> deleteJob({int? jobId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/Delete?Id=$jobId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/Delete?Id=$jobId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title:  languageCode == "hi" ? "कुछ गलत हो गया!" :'Something went wrong ',message:languageCode == "hi" ? "कृपया करके थोडी देर बाद प्रयाश करे" :'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<SuccessModel> createJob({required data}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      var body = data;
      log("Request :- ${body.toString()}");
      log("$baseUrl/AdminAPI/JobAPI/Save");

      final response = await http.post(
        Uri.parse(
          "$baseUrl/AdminAPI/JobAPI/Save",
        ),
        headers: {
          'Content-type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer ${apiToken.value}',
        },
        body: jsonEncode(body),
      );
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title:  languageCode == "hi" ? "कुछ गलत हो गया!" :'Something went wrong ',message:languageCode == "hi" ? "कृपया करके थोडी देर बाद प्रयाश करे" :'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...createJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<JobModel> getJobById({
    jobId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;


    if (jobId == null || jobId == "") {
      jobId = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/GetDataByJobID?ID=$jobId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetDataByJobID?ID=$jobId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return JobModel.fromJson(jsonDecode(responseJson));
        } else {
          return JobModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...getJobById ...... $e");
    }
    return JobModel.fromJson(jsonDecode(responseJson));
  }


  Future<SuccessModel> saveBide({int? jobId,double? cost}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;

    try {
      log("$baseUrl/VendorApi/VendorAPI/JobBidSave");

      final response = await http.post(
          Uri.parse(
            "$baseUrl/VendorApi/VendorAPI/JobBidSave",
          ),
          headers: {"Content-Type": "application/x-www-form-urlencoded",},
          body: {
            "JobID" :jobId,
            "Cost" : cost
          }
      );
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  ///------------------------------ Get JobBid -----------------------------------///
  Future<List<JobBidModel>> getJobBidList({
    pageNumber,
    rowsOfPage,
    orderByName,
    searchVal,
    fromDate,
    toDate,
    sortDirection,
    jobType,
    jobStatusId,
    jobId,
    tempStatusID,
    vendorID,
    userTypeID
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<JobBidModel> list = [];

    if (jobType == null || jobType == "") {
      jobType = "0";
    }
    if (jobStatusId == null || jobStatusId == "") {
      jobStatusId = "0";
    }
    if (jobId == null || jobId == "") {
      jobId = "0";
    }
    if (vendorID == null || vendorID == "") {
      vendorID = "0";
    }
    if (tempStatusID == null || tempStatusID == "") {
      tempStatusID = "0";
    }
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      var url;
      if(userTypeID == "1"){
        url = "/AdminApi/JobAllocationAPI/GetJobBidList2";
      }else{
        url="/VendorApi/VendorAPI/GetJobBidList";
      }

      log("$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&SearchVal=$searchVal&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobTypeID=$jobType&VendorID=$vendorID&TempStatusID=$tempStatusID");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&SearchVal=$searchVal&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobTypeID=$jobType&VendorID=$vendorID&TempStatusID=$tempStatusID",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson["data"].toString());

      for (int i = 0; i < responseJson['data'].length; i++) {
        list.add(JobBidModel.fromJson(responseJson['data'][i]));
      }
    } catch (e) {
      print("error ...getJobBidList ...... $e");
    }
    return list;
  }

///-----------------------------Apply job-------------------------------///

  Future<SuccessModel> applyJob({required data}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      var body = data;
      log("Request :- ${body.toString()}");
      log("$baseUrl/VendorApi/VendorAPI/JobBidSave");

      final response = await http.post(
        Uri.parse(
          "$baseUrl/VendorApi/VendorAPI/JobBidSave",
        ),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${apiToken.value}',
        },
        body: jsonEncode(body),
      );
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...createJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

///-----------------------------Create Job Allocation----------------------////


  Future<SuccessModel> createJobAllocation({required data}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      var body = data;
      log("Request :- ${body.toString()}");
      log("$baseUrl/AdminAPI/JobAllocationAPI/Save");

      final response = await http.post(
        Uri.parse(
          "$baseUrl/AdminAPI/JobAllocationAPI/Save",
        ),
        headers: {
          'Content-type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer ${apiToken.value}',
        },
        body: jsonEncode(body),
      );
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...createJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<List<FieldItemValueModel>> getVendorJobBide({jobId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/GetJobBidList?JobID=$jobId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/GetJobBidList?JobID=$jobId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }



///-----------------------------Job Allocation -----------------------///

  Future<List<JobAllocationListModel>> getJobAllocationList({
    pageNumber,
    rowsOfPage,
    orderByName,
    searchVal,
    fromDate,
    toDate,
    sortDirection,
    vendorID,
    userTypeID,
    jobId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<JobAllocationListModel> list = [];

    // if (jobType == null || jobType == "") {
    //   jobType = "0";
    // }

    if (jobId == null || jobId == "") {
      jobId = "0";
    }
    if (vendorID == null || vendorID == "") {
      vendorID = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      var url;
      if(userTypeID == "1"){
        url = "/AdminAPI/JobAllocationAPI/GetList";
      }else{
        url="/VendorApi/VendorAPI/GetJobAllocationList";
      }


      log("$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=0$jobId&VendorID=$vendorID");

      final response = await http.get(
          Uri.parse(
            "$baseUrl$url?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=0$jobId&VendorID=$vendorID",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson['data'].toString());

      for (int i = 0; i < responseJson['data'].length; i++) {
        list.add(JobAllocationListModel.fromJson(responseJson['data'][i]));
      }
    } catch (e) {
      print("error ...getJobAllocationList ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobName() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/GetJobList");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/GetJobList",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getVendorName() async {
    // bool isInternet = await Constants.isInternetAvail();
    // if (!isInternet) {
    //   Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    // }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/GetVendorList");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/GetVendorList",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(FieldItemValueModel.fromJson(responseJson[i]));
      }
    }catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<SuccessModel> deleteJobAllocation({int? jobAllocationId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/Delete?Id=$jobAllocationId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/Delete?Id=$jobAllocationId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<JobAllocationModel> getJobAllocationById({
    jobAllocationId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;


    if (jobAllocationId == null || jobAllocationId == "") {
      jobAllocationId = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/GetDataByJobAllocationID?ID=$jobAllocationId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/GetDataByJobAllocationID?ID=$jobAllocationId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return JobAllocationModel.fromJson(jsonDecode(responseJson));
        } else {
          return JobAllocationModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...getJobAllocationById ...... $e");
    }
    return JobAllocationModel.fromJson(jsonDecode(responseJson));
  }

///-----------------------------Vendor ------------------------------------------------////


  Future<SuccessModel> checkVendorPhone({String? phone}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;

    try {
      log("$baseUrl/api/CommanAPI/IsVendorPhoneNoExist?VendorId=0&Phone=$phone");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/api/CommanAPI/IsVendorPhoneNoExist?VendorId=0&Phone=$phone",
          ),
          headers: {"Content-Type": "application/x-www-form-urlencoded",},
          );
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...checkVendorPhone ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<List<VendorListModel>> getVendorList({
    pageNumber,
    rowsOfPage,
    orderByName,
    searchVal,
    fromDate,
    toDate,
    sortDirection,
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    List<VendorListModel> list = [];

    // if (vendorId == null || vendorId == "") {
    //   vendorId = "0";
    // }


    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminApi/VendorAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&VendorTypeID=0");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminApi/VendorAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&VendorTypeID=0",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson["data"].toString());

      for (int i = 0; i < responseJson['data'].length; i++) {
        list.add(VendorListModel.fromJson(responseJson['data'][i]));
      }
    } catch (e) {
      print("error ...getVendorList ...... $e");
    }
    return list;
  }

  Future<SuccessModel> vendorRegistration(
      {required Map<String, String> data,
        String? path}) async {
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {

      log("$baseUrl/AdminApi/VendorAPI/SaveVendor");
      log('$data');
      log('$path');
      var headers = {
        "Content-Type": "application/form-data",
        'Authorization': 'Bearer ${apiToken.value}'
      };

      var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrl/AdminApi/VendorAPI/SaveVendor"),
      );
      request.fields.addAll(data);
      // request.fields.addAll(jsonDecode(
      //   jsonEncode(body),
      // ));
      if (path != "" && path != null) {
        request.files.add(await http.MultipartFile.fromPath('AadharCardUpload', path));
      }
      request.headers.addAll(headers);

      var sendRequest = await request.send();
      var response = await http.Response.fromStream(sendRequest);
      responseJson = response.body.toString();
      log(responseJson);
      if(response.statusCode ==200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    }catch (e) {
      log("error ...vendorRegistration ...... $e");
    }
    return SuccessModel.fromJson(Map());
  }

  Future<VendorModel> getVendorById({
    vendorId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;


    if (vendorId == null || vendorId == "") {
      vendorId = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/VendorAPI/GetDataByVendorID?ID=$vendorId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/VendorAPI/GetDataByVendorID?ID=$vendorId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return VendorModel.fromJson(jsonDecode(responseJson));
        } else {
          return VendorModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...getVendorById ...... $e");
    }
    return VendorModel.fromJson(jsonDecode(responseJson));
  }

  Future<SuccessModel> deleteVendor({int? vendorId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/VendorAPI/Delete?Id=$vendorId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/VendorAPI/Delete?Id=$vendorId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<SuccessModel> approveVendor({int? vendorId,bool? isApprove}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: languageCode == "hi" ? "कोई इंटरनेट कनेक्शन नहीं" : 'No Internet connection',message:languageCode == "hi" ? "नेटवर्क से जुड़ें" :'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminApi/VendorAPI/Approve?ID=$vendorId&IsApproved=$isApprove");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminApi/VendorAPI/Approve?ID=$vendorId&IsApproved=$isApprove",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = response.body.toString();
      log(responseJson.toString());
      if(response.statusCode == 200){
        if (responseJson != null) {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        } else {
          return SuccessModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        return Get.offNamed(Routes.login);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw UnauthorisedException(response.body.toString());
      default:
        print('error : ${response.body}');
        Ui.ErrorSnackBar(
          title: 'Something Went Wrong!',
          message: 'Error occured while Communication with Server with StatusCode : ${response.statusCode}. Try Again Later',
        );
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}. Try Again Later',
        );
    }
  }


  //VendorApi/VendorAPI/JobBidSave - in vendor login for job bide save (in vendor login (JobID Required Cost Required numberRemark) )

}
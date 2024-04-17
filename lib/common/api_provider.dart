

// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mudara_steel_app/common/appconstant.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/custom_exceptions.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_list_model.dart';
import 'package:mudara_steel_app/model/job_list_model.dart';
import 'package:mudara_steel_app/model/jov_allocation_by_id_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class APIProvider {
  final String baseUrl = "http://116.72.8.100:2203"; // Testing
  // final String baseUrl = "http://103.209.145.199:2005"; //Live
  RxString userName = "".obs;
  RxString password = "".obs;
  RxString apiToken = "".obs;

  // String {{apiToken.value}} = Get.find<RootController>().token.value;
  // String userName = Get.find<RootController>().userName.value != "" ? Get.find<RootController>().userName.value : "AD";
  // String password = Get.find<RootController>().password.value != "" ? Get.find<RootController>().password.value : "furniture";



  RootController  rootController = Get.put(RootController());

  ///------------------------ Login -----------------------------------///


  Future<bool> login({required userName, required password}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    try {
      log("$baseUrl/token");

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
          GetStorage().write(Constants.userName, responseJson['UserType'].toString());
          GetStorage().write(Constants.userTypeID, responseJson['UserTypeID'].toString());
          // await APIProvider().getProfileData();
          return true;
        }
        else {
          Ui.ErrorSnackBar(title:'Unable to login',message:'${responseJson['error_description']}');
          return false;
        }
      } else {
        Ui.ErrorSnackBar(title:'Unable to login',message:'${responseJson['error_description']}');
        return false;
      }
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...login ...... $e");
    }
    return false;
  }


///---------------------------- Vendor Reg ---------------------------------------////

  Future<SuccessModel> registerVendor(
      {required Map<String, String> data,
        String? path}) async {
    var responseJson;
    try {

      log("$baseUrl/api/CommanAPI/SaveVendor");
      log('$data');
      log('$path');
      var headers = {"Content-Type": "application/x-www-form-urlencoded"};

      var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrl/api/CommanAPI/SaveVendor"),
      );
      request.fields.addAll(data);
      // request.fields.addAll(jsonDecode(
      //   jsonEncode(body),
      // ));
      if (path != "" && path != null) {
        request.files.add(await http.MultipartFile.fromPath('file', path));
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
      Ui.ErrorSnackBar(title: 'No Internet connection');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      log("error ...registerVendor ...... $e");
    }
    return SuccessModel.fromJson(Map());
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
    jobId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    List<JobListModel> list = [];

    // if (jobType == null || jobType == "") {
    //   jobType = "0";
    // }
    if (jobStatusId == null || jobStatusId == "") {
      jobStatusId = "0";
    }
    if (jobId == null || jobId == "") {
      jobId = "0";
    }

    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobType$jobType");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&JobStatusID=$jobStatusId&JobType$jobType",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getLeadList ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobNameList() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/GetJobList");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetJobList",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobStatusList() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/GetJobStatusList");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetJobStatusList",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobTypeList() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    List<FieldItemValueModel> list = [];
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAPI/GetJobTypeList");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetJobTypeList",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }


  Future<SuccessModel> deleteJob({int? jobId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<SuccessModel> createJob({required data}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...createJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

///-----------------------------Create Job Allocation----------------------////


  Future<SuccessModel> createJobAllocation({required data}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...createJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<List<FieldItemValueModel>> getVendorJobBide({int? jobId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
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
    jobId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
      log("$baseUrl/AdminAPI/JobAllocationAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&VendorID=$vendorID");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=$jobId&VendorID=$vendorID",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobAllocationList ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getJobName() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<List<FieldItemValueModel>> getVendorName() async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getJobName ...... $e");
    }
    return list;
  }

  Future<SuccessModel> deleteJobAllocation({int? jobId}) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminAPI/JobAllocationAPI/Delete?Id=$jobId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAllocationAPI/Delete?Id=$jobId",
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
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return SuccessModel.fromJson(Map());
    } catch (e) {
      print("error ...deleteJobAllocation ...... $e");
    }
    return SuccessModel.fromJson(jsonDecode(responseJson));
  }

  Future<JobAllocationByIdModel> getJobAllocationById({
    jobAllocationId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
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
          return JobAllocationByIdModel.fromJson(jsonDecode(responseJson));
        } else {
          return JobAllocationByIdModel.fromJson(jsonDecode(responseJson));
        }
      }else{
        Get.offNamed(Routes.login);
      }
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return JobAllocationByIdModel.fromJson(Map());
    } catch (e) {
      print("error ...getJobAllocationById ...... $e");
    }
    return JobAllocationByIdModel.fromJson(jsonDecode(responseJson));
  }

///-----------------------------Vendor ------------------------------------------------////

  Future<List<JobListModel>> getVendorList({
    pageNumber,
    rowsOfPage,
    orderByName,
    searchVal,
    fromDate,
    toDate,
    sortDirection,
    vendorId
  }) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    var responseJson;
    List<JobListModel> list = [];

    if (vendorId == null || vendorId == "") {
      vendorId = "0";
    }


    apiToken.value = GetStorage().read(Constants.token);
    log("apiToken => ${apiToken.value}");
    try {
      log("$baseUrl/AdminApi/VendorAPI/GetLis?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&VendorTypeID=$vendorId");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminApi/VendorAPI/GetLis?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&VendorTypeID=$vendorId",
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
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getLeadList ...... $e");
    }
    return list;
  }


  //AdminAPI/JobAPI/GetDataByJobID?ID=1 - get data by job


  //AdminAPI/VendorAPI/Save - vendor save API
  //AdminAPI/VendorAPI/Delete?Id=2 - vendor delete API
  // AdminApi/VendorAPI/GetList?PageNumber=0&RowsOfPage=10&OrderByName=CreatedOn&SortDirection=&FromDate=&ToDate=&VendorTypeID=0  - get vendor list
   //AdminAPI/VendorAPI/GetDataByVendorID?ID=1 - Get Vendor By Vendor ID
  //AdminAPI/VendorAPI/Save - Update Vendor
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

}
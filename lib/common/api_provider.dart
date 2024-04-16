

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
import 'package:mudara_steel_app/model/job_list_model.dart';
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
      log("$baseUrl/AdminAPI/JobAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=J$jobId&JobStatusID=$jobStatusId&JobType$jobType");

      final response = await http.get(
          Uri.parse(
            "$baseUrl/AdminAPI/JobAPI/GetList?PageNumber=$pageNumber&RowsOfPage=$rowsOfPage&OrderByName=$orderByName&SortDirection=$sortDirection&FromDate=$fromDate&ToDate=$toDate&JobID=J$jobId&JobStatusID=$jobStatusId&JobType$jobType",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${apiToken.value}',
          });
      responseJson = _response(response);
      log(responseJson.toString());

      for (int i = 0; i < responseJson.length; i++) {
        list.add(JobListModel.fromJson(responseJson[i]));
      }
    } on SocketException {
      Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
    } catch (e) {
      print("error ...getLeadList ...... $e");
    }
    return list;
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

}
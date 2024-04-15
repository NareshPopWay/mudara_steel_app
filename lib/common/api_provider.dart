

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
import 'package:mudara_steel_app/routes/app_routes.dart';

class APIProvider {

  ///------------------------ generateToken -----------------------------------///

  Future<bool> generateToken({required userName, required password,context}) async {
    var responseJson;
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
    }
    try {
      log(AppConstants.baseURL + AppConstants.tokenApi);
      // await GetStorage().write(AppConstants.userId, id.toString());
      final response = await http.post(
        Uri.parse(AppConstants.baseURL + AppConstants.tokenApi),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': 'application/json',
        },
        body: {
          "grant_type": "password",
          "UserName": userName.toString(),
          "Password": password.toString(),
        },
      );
      responseJson = json.decode(response.body.toString());
      log('Token Response :- $responseJson');
      log('access_token :- ${responseJson['access_token']}');
      if(response.statusCode == 200){
        if (responseJson['access_token'] != null &&
            responseJson['access_token'] != "") {
          GetStorage().write(AppConstants.token, responseJson['access_token'].toString());
          // APIProvider().updateFCMToken(token: responseJson['access_token']);
          return true;
        } else {
          return false;
        }
      } else {
       Ui.ErrorSnackBar(title:'Unable to login',message:'${responseJson['error_description']}');
        return false;
      }

    } on SocketException {
       Ui.worningSnackBar(title: 'Something went wrong ',message:'Please try again latter');
      return false;
    } catch (e) {
      log("error ...generateToken ...... $e");
    }
    return false;
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
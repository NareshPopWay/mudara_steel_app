
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CreateJobController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController jobName = TextEditingController();
  TextEditingController fromLocation = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController toLocation = TextEditingController();
  TextEditingController deliveryDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  RxString nextFollowUp = "".obs;

  Map data ={};

  RxBool isLoading = false.obs;
  RxBool isSaveArchitech = false.obs;

  @override
  void onInit() async {

    if (Get.arguments != null && Get.arguments is Map) {
      data = Get.arguments;

      jobName.text = data["jobName"].toString();
      fromLocation.text = data["fromLocation"].toString();
      toLocation.text = data["toLocation"].toString();
      deliveryDate.text = data["deliveryDate"].toString();
      weight.text = data["weight"].toString();
    }
    super.onInit();
  }



// Future<void> addLead()async{
//   bool isInternet = await Constants.isInternetAvail();
//   if (!isInternet) {
//     isLoading.value = false;
//     Constants.ErrorSnackBar(title:"No Internet connection",message: "Please turn on internet connection");
//     return;
//   }
//   try{
//     isLoading.value = true;
//     SuccessModel successModel =  await  APIProvider().addLead(
//       data: {
//         "Phone": phone.text,
//         "ClientId": selectedClientId.value,
//         "ClientName": name.text,
//         "Address": address.text,
//         "StateID": selectedStateId.value,
//         "CityID": selectedCityId.value,
//         "LeadSourceID": selectedLeadSourceId.value,
//         "RefBy": referenceBy.text,
//         "RefPhone": referencePhone.text,
//         "ArchitechEmpID": selectedArchitectNameId.value,
//         "EmployeeID": selectedSalesPersonId.value,
//         "Remark": remark.text,
//         "LeadStatusID": selectedStatusId.value,
//         "NextFollowupDate": tempNextFollowUp.text,
//         "objLeadDetail": List.from(selectedProductList.map((e) => e.toJson()).toList()),
//       },
//     );
//     if(successModel.msgType == 0){
//       isLoading.value = false;
//       Get.offAndToNamed(Routes.leadList);
//       // Constants.successSnackBar(title: "Lead Added Successfully");
//       Ui.SuccessSnackBar(title:'Successful',message:'Lead Added Successfully');
//     }else if(successModel.msgType == 1){
//       isLoading.value = false;
//       Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
//     }
//
//   }catch(e){
//     isLoading.value = false;
//     Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
//   }
// }


}

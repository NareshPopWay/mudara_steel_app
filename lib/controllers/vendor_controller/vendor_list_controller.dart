
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/model/vendor_list_model.dart';


class VendorListController extends GetxController {

  RxList<VendorListModel> vendorList = RxList();
  ScrollController leadScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();

  int vendorPage = 0;
  RxBool isSearching = RxBool(false);

  var showCount = [10, 15, 20, 25, 50, 100];
  RxInt showCountVal = 10.obs;

  List<DropdownMenuItem<Object?>> buildsShowCountItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return items;
  }

  onChangeShowCount(newValue) {
    print(newValue);
    showCountVal.value = newValue!;
    vendorPage = 0;
    vendorList.clear();
    getVendor();
  }

  RxString shortByVal = "LeadDate".obs;
  RxString selectedShortByVal = "CreatedOn".obs;
  RxString descending = "desc".obs;
  RxString ascending = "asc".obs;

  RxBool isDescending = RxBool(false);

  RxBool isLoading = false.obs;
  RxBool isVendorListLoading = false.obs;

  TextEditingController tempToDate = TextEditingController();
  TextEditingController tempFromDate = TextEditingController();

  RxString fromDate = "".obs;
  RxString toDate = "".obs;



  @override
  void onInit() async {
    leadScrollController.addListener(vendorScrollListener);
    getVendor();
    super.onInit();
  }

  //
  // RxList<FieldItemValueModel> jobNameList = <FieldItemValueModel>[].obs;
  // RxBool isJobNameExpanded = false.obs;
  // RxString selectedJobName = "".obs;
  // RxString selectedJobNameId = "".obs;
  // RxString tampSelectedJobName = "".obs;
  // RxString tampSelectedJobNameId = "".obs;
  // RxBool isJobNameSearching = RxBool(false);
  // Rx<TextEditingController> textJobName = TextEditingController().obs;
  //
  // RxList<FieldItemValueModel> vendorNameList = <FieldItemValueModel>[].obs;
  // RxBool isVendorNameExpanded = false.obs;
  // RxString selectedVendorName = "".obs;
  // RxString selectedVendorNameId = "".obs;
  // RxString tampSelectedVendorName = "".obs;
  // RxString tampSelectedVendorNameId = "".obs;
  // RxBool isVendorNameSearching = RxBool(false);
  // Rx<TextEditingController> textVendorName = TextEditingController().obs;


  void vendorScrollListener() async {
    double maxScroll = leadScrollController.position.maxScrollExtent;
    double currentScroll = leadScrollController.position.pixels;
    double delta = Get.height / 3;
    if (maxScroll - currentScroll <= delta && !isVendorListLoading.value) {
      await getVendor(pagination: true);
    }
  }

  Future<void> getVendor({bool pagination = false}) async {
    isVendorListLoading.value = true;

    var vendorResponse = await APIProvider().getVendorList(
      pageNumber: vendorPage,
      rowsOfPage: showCountVal,
      orderByName: selectedShortByVal,
      searchVal: searchTextEditController.text,
      fromDate: fromDate.value,
      toDate: toDate.value,
      sortDirection: isDescending.value == true ? ascending.value: descending.value,
    );
    if (vendorResponse.isNotEmpty) {
      vendorPage++;
      vendorList.addAll(vendorResponse);
    }
    isVendorListLoading.value = false;
    return;
  }


  Future<void> approveVendor(context,{int? vendorId,bool? isApprove})async{
    try{
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().approveVendor(vendorId: vendorId,isApprove: isApprove );
      if(successModel.msgType == 0){
        isLoading.value = false;
        vendorPage = 0;
        vendorList.clear();
        getVendor();
        Ui.SuccessSnackBar(title:'Successful',message: isApprove == true ? 'Vendor Approved successfully done' : 'Vendor DisApproved successfully done');
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Vendor not deleted");
    }
  }

  RxBool isDeleteVendor = false.obs;

  Future<void> deleteVendor(context,{int? vendorId})async{
    try{
      FocusScope.of(context).unfocus();
      isDeleteVendor.value = true;
      SuccessModel successModel =  await  APIProvider().deleteVendor(vendorId: vendorId);
      if(successModel.msgType == 0){
        isDeleteVendor.value = false;
        Get.back();
        vendorPage = 0;
        vendorList.clear();
        getVendor();
        Ui.SuccessSnackBar(title:'Successful',message:'Vendor deleted successful');
      }else if(successModel.msgType == 1){
        isDeleteVendor.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isDeleteVendor.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Vendor not deleted");
    }
  }

  Future<void> checkVendorPhone(context,{String? phone})async{
    try{
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().checkVendorPhone(phone: phone);
      if(successModel.msgType == 0){
        isLoading.value = false;
         /// Api Call

      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }
    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Vendor not deleted");
    }
  }
}

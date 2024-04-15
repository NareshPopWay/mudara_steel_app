
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import '../../CustomExpensionPanel/expansion_panel.dart';
import '../../spacing.dart';
import '../../themeService.dart';


searchDropDwonWidget({
  required RxString selectedValue,
  required RxString selectedId,
  required String emptyTitle,
  required List<FieldItemValueModel> list,
  required RxBool isExpanded,
  required Rx<TextEditingController> textfield,
  required RxBool isSearching,
  Function? fun,
  final ValueChanged<String>? onFieldSubmitted,

  final Function()? onTap,
  final FormFieldSetter<String>? onSaved,
}) {
  textfield.value.text = selectedValue.value;
  textfield.value.selection = TextSelection.fromPosition(
    TextPosition(offset: textfield.value.text.length),
  );
  final RxList<FieldItemValueModel> searchResult = RxList();

  return Obx(
    () => Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isExpanded == true ? ThemeService.primaryColor : ThemeService.grey,
        ),
        borderRadius: BorderRadius.circular(AppSpacings.s15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacings.s14),
        child: CustomExpansionPanelList(
          animationDuration: const Duration(milliseconds: 300),
          expandedHeaderPadding: EdgeInsets.zero,
          children: [
            CustomExpansionPanel(
              headerBuilder: (context, isExpandeds) {
                return Container(
                  color:  isExpanded == true ? ThemeService.primaryColor : ThemeService.white,
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: AppSpacings.s12),
                          child: selectedValue.value != ""
                              ? Text(
                            isExpanded == true ? emptyTitle : selectedValue.value,
                            overflow: TextOverflow.fade,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontSize: AppSpacings.s20,
                              fontWeight: FontWeight.w600,
                              color: isExpanded == true ? ThemeService.white :ThemeService.black,
                            ),
                          )
                              : Text(
                            emptyTitle,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontSize: AppSpacings.s20,
                              fontWeight: FontWeight.w600,
                              color: isExpanded == true ?  ThemeService.white :ThemeService.grayScalecon,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              body: Obx(() => buildListView(
                    textfield: textfield,
                    isExpanded: isExpanded,
                    isSearching: isSearching,
                    list: list,
                    searchResult: searchResult,
                    selectedId: selectedId,
                    selectedValue: selectedValue,
                    fun: fun,
                    emptyTitle:emptyTitle,
                    onTap:onTap ,
                    onFieldSubmitted: onFieldSubmitted,
                    onSaved:onSaved ,
                  )),
              isExpanded: isExpanded.value,
            ),
          ],
          dividerColor: Colors.grey,
          expansionCallback: (panelIndex, isExpandeds) {
            isExpanded.value = !isExpanded.value;
          },
        ),
      ),
    ),
  );
}

buildListView({
  required RxBool isExpanded,
  required String emptyTitle,
  required RxList<FieldItemValueModel> searchResult,
  required List<FieldItemValueModel> list,
  required Rx<TextEditingController> textfield,
  required RxBool isSearching,
  required RxString selectedValue,
  required RxString selectedId,
  Function? fun,
  final ValueChanged<String>? onFieldSubmitted,

  final Function()? onTap,
  final FormFieldSetter<String>? onSaved,
}) {
  List<FieldItemValueModel> dataList;
  if (searchResult.isNotEmpty || textfield.value.text.isNotEmpty) {
    dataList = searchResult;
  } else {
    dataList = list;
  }
  return SizedBox(
    height: dataList.isEmpty
        ? AppSpacings.s150
        : dataList.length <= 2
            ? AppSpacings.s180
            : dataList.length == 3
                ? AppSpacings.s250
                : AppSpacings.s300,
    child:  Column(
          children: [
            // Center(
            //   child: TextFieldWidget(
            //     leftPadding: 0,
            //     rightPadding: 0,
            //     padding: EdgeInsets.zero,
            //     autoFocus: false,
            //     removeBorder: true,
            //     inputFormatters: [
            //       FilteringTextInputFormatter.allow(RegExp(r"[ A-Za-z ]")),
            //       FilteringTextInputFormatter.deny(RegExp(r"^[ \t]+")),
            //     ],
            //     hintText: 'Search product',
            //     suffixIcon: SizedBox(
            //         width: AppSpacings.s2,
            //         child: const Icon(
            //           Icons.add,
            //           color: Colors.transparent,
            //           size: 1,
            //         )),
            //     textInputAction: TextInputAction.done,
            //     keyboardType: TextInputType.text,
            //     controller: textfield.value,
            //     onChanged: (value) {
            //       onSearchTextChanged(
            //         value,
            //         isExpanded: isExpanded,
            //         isSearching: isSearching,
            //         list: list,
            //         searchResult: searchResult,
            //       );
            //     },
            //     onSaved:onSaved,
            //     onFieldSubmitted: onFieldSubmitted,
            //     onTab:onTap,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(AppSpacings.s15, AppSpacings.s15,
                  AppSpacings.s15, 0),
              child: Center(
                child: CupertinoSearchTextField(
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: ThemeService.border,
                  itemColor: ThemeService.black,
                  placeholder: 'Search Product',
                  controller: textfield.value,
                  placeholderStyle: TextStyle(
                      fontSize: AppSpacings.s16,
                      color: Get.theme.disabledColor),
                  onSuffixTap: () {
                    isSearching.value = false;
                    searchResult.clear();
                    textfield.value.clear();
                  },
                  onChanged: (value) {
                    onSearchTextChanged(
                      value,
                      isExpanded: isExpanded,
                      isSearching: isSearching,
                      list: list,
                      searchResult: searchResult,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: AppSpacings.s20,),
            dataList.isEmpty
                ? Center(
              child: Text(
                "No Data Found",
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontSize: AppSpacings.s15,
                  color: ThemeService.black.withOpacity(0.8),
                ),
              ),
            )
                : Expanded(
                  child: ListView.separated(
                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        onSearchTextChanged(
                          dataList[index].text ?? "",
                          isExpanded: isExpanded,
                          isSearching: isSearching,
                          list: list,
                          searchResult: searchResult,
                        );
                        FocusManager.instance.primaryFocus?.unfocus();
                        isExpanded.value = !isExpanded.value;
                        textfield.value.text = dataList[index].text ?? "";
                        selectedValue.value = dataList[index].text ?? "";
                        selectedId.value = dataList[index].value ?? "";
                        textfield.value.selection = TextSelection.fromPosition(
                          TextPosition(offset: textfield.value.text.length),
                        );
                        if (fun != null) {
                          fun();
                        }
                      },
                      child: ListTile(
                        title: Text(
                          dataList[index].text ?? "",
                          style: Get.textTheme.bodyLarge?.copyWith(
                            fontSize: AppSpacings.s19,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans-Semibold',
                            color: ThemeService.black,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    indent: AppSpacings.s10,
                    color: ThemeService.border,
                    endIndent: AppSpacings.s10,
                  ),
                  itemCount: dataList.length,
                                ),
                ),
            SizedBox(height: AppSpacings.s10,),
          ],
        ),
  );
}

void onSearchTextChanged(
  String text, {
  required RxBool isExpanded,
  required RxList searchResult,
  required List<FieldItemValueModel> list,
  required RxBool isSearching,
}) async {
  isExpanded.value = true;
  searchResult.clear();
  isSearching.value = text.isNotEmpty;
  if (text.isEmpty) {
    return;
  }
  for (var searchText in list) {
    if ((searchText.text.toString().trim()).toLowerCase().contains(text.trim().toLowerCase())) {
      searchResult.add(searchText);
    }
  }
}

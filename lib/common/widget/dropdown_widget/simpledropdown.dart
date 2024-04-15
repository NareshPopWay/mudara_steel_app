
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/CustomExpensionPanel/expansion_panel.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import '../../spacing.dart';
import '../../themeService.dart';

dropDwonWidget({
  required RxString selectedValue,
  required RxString selectedId,
  required String emptyTitle,
  required List<FieldItemValueModel> list,
  required RxBool isExpanded,
  Function? fun,
}) {
  return Obx(
        () => Container(
          // padding: EdgeInsets.only(
          //   top: AppSpacings.s8,bottom: AppSpacings.s6
          // ),
        decoration: BoxDecoration(
          border: Border.all(
              color: isExpanded == true ? ThemeService.primaryColor : ThemeService.grey,
          ),
          borderRadius: BorderRadius.circular(AppSpacings.s16),
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacings.s14),
        child: CustomExpansionPanelList(
          animationDuration: const Duration(milliseconds: 300),
          expandedHeaderPadding: EdgeInsets.zero,
          children: [
            CustomExpansionPanel(
              headerBuilder: (context, isExpanded) {
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
                              color: isExpanded == true ?  ThemeService.white :ThemeService.black,
                            ),
                          )
                              : Text(
                            emptyTitle,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontSize: AppSpacings.s20,
                              fontWeight: FontWeight.w600,
                              color: isExpanded == true ?  ThemeService.white :ThemeService.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              canTapOnHeader: true,
              body: SizedBox(
                height: list.isEmpty
                    ? AppSpacings.s70
                    : list.length <= 2
                    ? AppSpacings.s150
                    : list.length == 3
                    ? AppSpacings.s200
                    : AppSpacings.s300,
                child: list.isEmpty
                    ? Center(
                  child: Text(
                    "No Data Found",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontSize: AppSpacings.s15,
                      color: ThemeService.black,
                    ),
                  ),
                )
                    : ListView.separated(
                  shrinkWrap: true,
                  primary: true,
                  physics: const BouncingScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        isExpanded.value = !isExpanded.value;
                        selectedValue.value = list[index].text ?? "";
                        selectedId.value = list[index].value ?? "";
                        if (fun != null) {
                          fun();
                        }
                      },
                      child: ListTile(
                        title: Text(
                          list[index].text ?? "",
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
                  itemCount: list.length,
                ),
              ),
              isExpanded: isExpanded.value,
            ),
          ],
          dividerColor: ThemeService.border,
          expansionCallback: (panelIndex, isExpandeds) {
            isExpanded.value = !isExpanded.value;
          },
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_shared_preferences/models/pos_session/posSession.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_enums.dart';
import 'package:shared_widgets/shared_widgets/app_button.dart';
import 'package:shared_widgets/shared_widgets/app_dialog.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/app_snack_bar.dart';
import 'package:shared_widgets/shared_widgets/app_text_field.dart';
import 'package:shared_widgets/utils/response_result.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/presentation/session_screen.dart';

void startNewSession({required BuildContext context}) {
  SessionController sessionController = Get.isRegistered<SessionController>()
      ? Get.find<SessionController>()
      : Get.put(SessionController());
  final formKey = GlobalKey<FormState>();
  FocusNode focusPrice = FocusNode();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    focusPrice.requestFocus();
  });

  onPressed() async {
    sessionController.isLoading.value = true;
    ResponseResult result = await sessionController.openOrResumeSession(
        balance: sessionController.price.text.isNotEmpty
            ? double.parse(sessionController.price.text)
            : 0.0);
    if (result.status) {
      await sessionController.posSessionsData();
      List<PosSession> sessionObj = sessionController.posSessionsList;
      sessionController.price.text = '';
      await SharedPr.setCurrentSaleSessionId(
          currentSaleSessionId: sessionObj.last);
      sessionController.isLoading.value = false;
      Get.close(1);
      Get.to(() => const SessionScreen());
      sessionController.update(['Sessionbutton']);
    } else {
      sessionController.isLoading.value = false;
      appSnackBar(
          message: result.message,
          messageType: MessageTypes.error,
          isDismissible: false);
    }
  }

  CustomDialog.getInstance()
      .dialogcontent(
    barrierDismissible: true,
    content: Container(
      height: 150.h,
      width: 100.w,
      padding: EdgeInsets.all(20.r),
      child: Obx(() => IgnorePointer(
          ignoring: sessionController.isLoading.value,
          child: Stack(children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "startNewSession".tr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r),
                  ),
                  SizedBox(height: 10.r),

                  ContainerTextField(
                      width: 100.w,
                      height: 30.h,
                      fontSize: 3.w,
                      borderColor: AppColor.silverGray,
                      iconcolor: AppColor.silverGray,
                      hintcolor: AppColor.silverGray,
                      showLable: true,
                      isAddOrEdit: true,
                      borderRadius: 5.r,
                      controller: sessionController.price,
                      focusNode: focusPrice,
                      prefixIcon: Icon(
                        Icons.price_change_outlined,
                        size: 4.sp,
                        color: AppColor.silverGray,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9\$]+')),
                      ],
                      hintText: 'openingBalanceSession'.tr,
                      labelText: 'openingBalanceSession'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "requiedField".tr;
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) async {
                        onPressed();
                      }),
                  SizedBox(height: 10.r),
                  ButtonElevated(
                      width: 100.w,
                      height: 30.h,
                      text: "startNewSession".tr,
                      borderRadius: 9,
                      textStyle:
                          TextStyle(fontSize: 3.w, color: AppColor.white),
                      backgroundColor: AppColor.cyanTeal,
                      onPressed:
                          onPressed) // Return an empty widget when not loading
                ],
              ),
            ),
            sessionController.isLoading.value
                ? const LoadingWidget()
                : Container(),
          ]))),
    ),
    context: context,
  )
      .then((_) {
    sessionController.price.text = '';
  });
}

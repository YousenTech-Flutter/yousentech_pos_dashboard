import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_provider.dart';
import 'package:yousentech_pos_invoice/invoices/presentation/invoice_home.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';

void startNewSession({required BuildContext context}) {
  SessionController sessionController =
      Get.isRegistered<SessionController>()
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
      balance:
          sessionController.price.text.isNotEmpty
              ? double.parse(sessionController.price.text)
              : 0.0,
    );
    if (result.status) {
      await sessionController.posSessionsData();
      List<PosSession> sessionObj = sessionController.posSessionsList;
      sessionController.price.text = '';
      await SharedPr.setCurrentSaleSessionId(
        currentSaleSessionId: sessionObj.last,
      );
      sessionController.isLoading.value = false;
      Get.close(1);
      // Get.to(() => const InvoiceScreen());
      Get.to(() =>  InvoiceHome());
      sessionController.update(['Sessionbutton']);
    } else {
      sessionController.isLoading.value = false;
      appSnackBar(
        message: result.message,
        messageType: MessageTypes.error,
        isDismissible: false,
      );
    }
  }

  dialogcontent(
    barrierDismissible: true,
    content: Builder(
      builder: (context) {
        return SizeProvider(
          baseSize: Size(context.setWidth(454.48), context.setHeight(220)),
          width: context.setWidth(454.48),
          height: context.setHeight(220),
          child: Container(
            width: context.setWidth(454.48),
            height: context.setHeight(220),
            padding: EdgeInsets.all(context.setMinSize(20)),
            child: Obx(
              () => IgnorePointer(
                ignoring: sessionController.isLoading.value,
                child: Stack(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: context.setHeight(20),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "startNewSession".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  SharedPr.isDarkMode!
                                      ? Colors.white
                                      : const Color(0xFF2E2E2E),
                              fontSize: context.setSp(20.03),
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          ContainerTextField(
                            controller: sessionController.price,
                            focusNode: focusPrice,
                            width: context.screenWidth,
                            height: context.setHeight(51.28),
                            fontSize: context.setSp(12),
                            testFontSize:context.setSp(16) ,
                            borderColor:
                                !SharedPr.isDarkMode!
                                    ? Color(0xFFC2C3CB)
                                    : null,
                            fillColor:
                                !SharedPr.isDarkMode!
                                    ? Colors.white.withValues(alpha: 0.43)
                                    : const Color(0xFF2B2B2B),
                            hintcolor:
                                !SharedPr.isDarkMode!
                                    ? Color(0xFF585858)
                                    : const Color(0xFFC2C3CB),
                            color:
                                !SharedPr.isDarkMode!
                                    ? Color(0xFF585858)
                                    : const Color(0xFFC2C3CB),
                            isAddOrEdit: true,
                            borderRadius: context.setMinSize(5),
                            hintText: 'openingBalanceSession'.tr,
                            labelText: 'openingBalanceSession'.tr,

                            prefixIcon: Icon(
                              Icons.price_change_outlined,
                              size: context.setMinSize(25),
                              color: const Color(0xFF16A6B7),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9\$]+'),
                              ),
                            ],

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "requiedField".tr;
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) async {
                              onPressed();
                            },
                          ),
                          Spacer(),
                          ButtonElevated(
                            height: context.setHeight(35),
                            text: "startNewSession".tr,
                            borderRadius: context.setMinSize(5),
                            textStyle: TextStyle(
                              fontSize: context.setSp(14),
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                            backgroundColor: AppColor.cyanTeal,
                            onPressed: onPressed,
                          ), // Return an empty widget when not loading
                        ],
                      ),
                    ),
                    sessionController.isLoading.value
                        ? const LoadingWidget()
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
    context: context,
  ).then((_) {
    sessionController.price.text = '';
  });
}

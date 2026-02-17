import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_shared_preferences/models/pos_session/posSession.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_enums.dart';
import 'package:shared_widgets/config/app_theme.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/shared_widgets/app_button.dart';
import 'package:shared_widgets/shared_widgets/app_dialog.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/app_snack_bar.dart';
import 'package:shared_widgets/shared_widgets/app_text_field.dart';
import 'package:shared_widgets/utils/response_result.dart';
import 'package:shared_widgets/utils/responsive_helpers/device_utils.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_provider.dart';
import 'package:yousentech_pos_invoice/invoices/presentation/invoice_home.dart';
import 'package:yousentech_pos_invoice/invoices/presentation/invoice_screen_mobile.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';

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
      Get.to(() => DeviceUtils.isMobile(context) ? InvoiceScreenMobile() : InvoiceHome() , routeName: DeviceUtils.isMobile(context) ? "/InvoiceScreenMobile" :  "/InvoiceHome");
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
        return Container(
          width: context.setWidth(454.48),
          padding: EdgeInsets.all(context.setMinSize(20)),
          child: Obx(
            () => IgnorePointer(
              ignoring: sessionController.isLoading.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
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
                                    Get.find<ThemeController>().isDarkMode.value
                                        ? AppColor.white
                                        : AppColor.black,
                                fontSize: context.setSp(DeviceUtils.isMobile(context) ? 16 : 20.03),
                                fontFamily: DeviceUtils.isMobile(context) ?'SansMedium' : 'Tajawal',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          
                            ContainerTextField(
                              controller: sessionController.price,
                              focusNode: focusPrice,
                              width: context.screenWidth,
                              height: context.setHeight(DeviceUtils.isMobile(context) ? 40 : 51.28),
                              fontSize: context.setSp(12),
                              testFontSize: context.setSp(15),
                              borderColor:
                                  !Get.find<ThemeController>().isDarkMode.value
                                      ? const Color(0xFFC2C3CB)
                                      : null,
                              fillColor:
                                  !Get.find<ThemeController>().isDarkMode.value
                                      ? AppColor.white.withValues(alpha: 0.43)
                                      : const Color(0xFF2B2B2B),
                              hintcolor:
                                  !Get.find<ThemeController>().isDarkMode.value
                                      ? const Color(0xFFC2C3CB)
                                      : const Color(0xFFC2C3CB),
                              color: !Get.find<ThemeController>().isDarkMode.value
                                  ? const Color(0xFFC2C3CB)
                                  : const Color(0xFFC2C3CB),
                              contentPadding: EdgeInsets.fromLTRB(
                                context.setWidth(
                                  14.82,
                                ),
                                context.setHeight(
                                  15.22,
                                ),
                                context.setWidth(
                                  14.82,
                                ),
                                context.setHeight(
                                  15.22,
                                ),
                              ),
                              isAddOrEdit: true,
                              borderRadius: context.setMinSize(5),
                              hintText: 'openingBalanceSession'.tr,
                              labelText: 'openingBalanceSession'.tr,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.setWidth(
                                    14,
                                  ),
                                ),
                                child: Icon(
                                  Icons.price_change_outlined,
                                  size: context.setMinSize(25),
                                  color: AppColor.appColor,
                                ),
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
                            // Spacer(),
                            ButtonElevated(
                              height: context.setHeight(35),
                              width: double.infinity,
                              text: "startNewSession".tr,
                              borderRadius: context.setMinSize(5),
                              textStyle: TextStyle(
                                fontSize: context.setSp(DeviceUtils.isMobile(context) ? 14 : 18),
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: DeviceUtils.isMobile(context) ?'SansMedium' : 'Tajawal',
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
                ],
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

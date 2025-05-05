import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_styles.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/utils/show_pending_deletion_confirm_dialog.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final int? count;
  final String total;
  final String icon;
  final Color color;
  final bool? showDeletIcon;
  final bool? showSendIcon;
  final bool isMiddle;
  final bool isdashbord;
  final String? state;
  final double? height;

  CustomCard({
    super.key,
    required this.title,
    this.count,
    required this.total,
    required this.icon,
    required this.color,
    this.state,
    this.height,
    this.isMiddle = false,
    this.isdashbord = false,
    this.showDeletIcon = false,
    this.showSendIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height ?? 0.19.sh,
        margin: isMiddle ? EdgeInsets.symmetric(horizontal: 10.0.r) : null,
        padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.r),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.softIceBlue,
              blurRadius: 60,
              offset: const Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: SvgPicture.asset(
                              icon,
                              package: 'yousentech_pos_dashboard',
                              color: AppColor.white,
                              width: 15.r,
                              height: 15.r,
                            )),
                        SizedBox(
                          width: 10.r,
                        ),
                        Column(
                          children: [
                            Text(
                              title.tr,
                              style: AppStyle.stylew700.copyWith(
                                  fontSize: 10.r, color: AppColor.darkGray),
                            ),
                            if (isdashbord)
                              Text(
                                "(${"vat_included".tr})",
                                style: TextStyle(
                                  fontSize: 9.r,
                                  color: AppColor.lavenderGray,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (count != null) ...[
                  SizedBox(height: 5.r),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 39.r),
                    child: Text(
                      '( ${"count".tr} $count )',
                      style: AppStyle.stylew700.copyWith(
                          fontSize: 8.r, color: AppColor.lavenderGray),
                    ),
                  ),
                ]
              ],
            ),
            Column(
              children: [
                SizedBox(height: 5.r),
                Row(
                  children: [
                    if (showDeletIcon!) ...[
                      InkWell(
                        onTap: () {
                          SessionController sessionController =
                              Get.find<SessionController>();
                          showPendingInvoiceDeletionConfirmDialog(
                              sessionController: sessionController);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                  color: AppColor.palePink,
                                  borderRadius: BorderRadius.circular(5)),
                              child: SvgPicture.asset(
                                "assets/image/delete.svg",
                                package: 'yousentech_pos_dashboard',
                                width: 13.r,
                                height: 13.r,
                              )),
                        ),
                      ),
                    ] else if (showSendIcon! && count! > 0) ...[
                      InkWell(
                        onTap: () async {
                          SessionController sessionController =
                              Get.find<SessionController>();
                          await sessionController.sendAllDraftInvoiceToServer();
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(5)),
                              child: SvgPicture.asset(
                                "assets/image/send.svg",
                                package: 'yousentech_pos_dashboard',
                                width: 13.r,
                                height: 13.r,
                              )),
                        ),
                      ),
                    ],
                    //  SizedBox(width: 2.r),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 15.r,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${"total".tr}:',
                              style: AppStyle.stylew700.copyWith(
                                  fontSize: 10.r, color: AppColor.stoneGray),
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: total,
                                      style: AppStyle.stylew700.copyWith(
                                        color: AppColor.gunmetalGray,
                                        fontSize: 10.r,
                                      )),
                                  TextSpan(
                                      text: ' ${"S.R".tr}',
                                      style: AppStyle.stylew400.copyWith(
                                        color: AppColor.lavenderGray,
                                        fontSize: 8.r,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

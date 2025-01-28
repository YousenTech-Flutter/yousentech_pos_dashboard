import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:yousentech_pos_dashboard/config/app_enums.dart';

class TotalCard extends StatelessWidget {
  TotalCard({
    super.key,
    this.isMiddle = false,
    this.totalPrice,
    required this.info,
  });
  InfoTotalCard info;
  bool isMiddle;
  String? totalPrice;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 0.1.sh,
        margin: EdgeInsets.symmetric(
            vertical: 5.r, horizontal: isMiddle ? 10.r : 0),
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: ScreenUtil().screenHeight,
              decoration: BoxDecoration(
                color: info.color,
                borderRadius: SharedPr.lang == 'en'
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    info.icon,
                    clipBehavior: Clip.antiAlias,
                    fit: BoxFit.fill,
                    width: 20.r,
                    height: 20.r,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    info.text.tr,
                    style: TextStyle(
                        fontSize: 10.r,
                        color: AppColor.dimGray,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "(${"vat_included".tr})",
                    style: TextStyle(
                      fontSize: 8.r,
                      color: AppColor.lavenderGray,
                    ),
                  ),
                  SizedBox(height: 5.r),
                  Text(
                    "$totalPrice",
                    style: TextStyle(
                        fontSize: 8.r,
                        color: AppColor.jetBlack,
                        fontWeight: FontWeight.w700),
                  ),
                  // Directionality(
                  //   textDirection: TextDirection.ltr,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "% ${info.percentage} ".tr,
                  //         style: TextStyle(
                  //             fontSize: 8.r,
                  //             color: AppColor.brightAqua,
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //       SvgPicture.asset(
                  //         'assets/image/arrow_totalcard.svg',
                  //         clipBehavior: Clip.antiAlias,
                  //         fit: BoxFit.fill,
                  //         width: 8.r,
                  //         height: 8.r,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

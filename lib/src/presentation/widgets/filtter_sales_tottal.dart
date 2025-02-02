import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:yousentech_pos_session/src/domain/session_viewmodel.dart';
class FiltterSalesTottal extends StatelessWidget {
  FiltterSalesTottal({super.key, required this.id, required this.text});

  String text;
  int id;
  SessionController sessionController = Get.put(SessionController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sessionController.selectedPeriod = id;
        sessionController.update();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 8.r),
        decoration: sessionController.selectedPeriod == id
            ? BoxDecoration(
                color: AppColor.cyanTeal,
                borderRadius: BorderRadius.circular(8.r))
            : null,
        child: Text(
          text.tr,
          style: TextStyle(
              fontSize: 7.r,
              color: sessionController.selectedPeriod == id
                  ? AppColor.white
                  : AppColor.gray,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

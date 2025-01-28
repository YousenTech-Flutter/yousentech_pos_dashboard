// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_styles.dart';
import 'package:yousentech_pos_loading_synchronizing_data/yousentech_pos_loading_synchronizing_data.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  LoadingDataController loadingDataController =
      Get.put(LoadingDataController());
  final LoadingItemsCountController _loadingItemsCountController =
      Get.put(LoadingItemsCountController());
  var _overlayPortalController = OverlayPortalController();
  @override
  void initState() {
    _overlayPortalController.toggle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Container();

    return OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          return Positioned(
            child: Material(
                color: AppColor.white.withOpacity(0.6),
                child: Obx(() {
                  return Center(
                    child: SizedBox(
                      width: Get.width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image/logoGif.gif',
                            fit: BoxFit.contain,
                            width: 50.r,
                            height: 50.r,
                            filterQuality: FilterQuality.high,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${loadingDataController.loadTital.value} ",
                                      style: AppStyle.stylenormal.copyWith(
                                          color: AppColor.gray,
                                          fontSize: 10.r)),
                                  loadingDataController.isLoadData.value
                                      ? Text("...",
                                          style: AppStyle.stylenormal.copyWith(
                                              color: AppColor.gray,
                                              fontSize: 10.r))
                                      : Text(
                                          "( ${_loadingItemsCountController.loadingItemCount.value.toString()} ",
                                          style: AppStyle.stylenormal.copyWith(
                                              color: AppColor.gray,
                                              fontSize: 10.r)),
                                  loadingDataController.isLoadData.value
                                      ? Container()
                                      : Text(
                                          "/ ${loadingDataController.lengthRemote.value} )",
                                          style: AppStyle.stylenormal.copyWith(
                                              color: AppColor.gray,
                                              fontSize: 10.r)),
                                ],
                              ),
                            ),
                          ),
                          (loadingDataController.isLoad.value)
                              ? SizedBox(
                                  width: Get.width / 7,
                                  child: LinearProgressIndicator(
                                      color: AppColor.cyanTeal,
                                      borderRadius:
                                          BorderRadius.circular(10.r)))
                              : Container()
                        ],
                      ),
                    ),
                  );
                })),
          );
        });
  }
}

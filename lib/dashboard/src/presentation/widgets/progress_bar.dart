// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_images.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_item_count_controller.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  LoadingDataController loadingDataController = Get.put(
    LoadingDataController(),
  );
  final LoadingItemsCountController _loadingItemsCountController = Get.put(
    LoadingItemsCountController(),
  );
  var _overlayPortalController = OverlayPortalController();
  @override
  void initState() {
    _overlayPortalController.toggle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayPortalController,
      overlayChildBuilder: (context) {
        return Positioned(
          child: Obx(() {
              return Material(
                color: Get.find<ThemeController>().isDarkMode.value  ? AppColor. darkModeBackgroundColor : Color(0xFFDDDDDD),
                child:  Center(
                    child: SizedBox(
                      width: context.setWidth(454.48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logoGif,
                            package: 'shared_widgets',
                            fit: BoxFit.contain,
                            width: context.setMinSize(50),
                            height: context.setMinSize(50),
                            filterQuality: FilterQuality.high,
                          ),
                          Padding(
                            padding: EdgeInsets.all(context.setMinSize(8)),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${loadingDataController.loadTital.value} ",
                                    style: TextStyle(
                                      color:Get.find<ThemeController>().isDarkMode.value 
                                              ? AppColor.white : AppColor.black,
                                      fontSize: context.setSp(16),
                                      fontWeight: FontWeight.w500,
                                      height: 1.43,
                                    ),
                                  ),
                                  loadingDataController.isLoadData.value
                                      ? Text(
                                        "...",
                                        style: TextStyle(
                                          color:Get.find<ThemeController>().isDarkMode.value 
                                              ? AppColor.white : AppColor.black,
                                          fontSize: context.setSp(16),
                                          fontWeight: FontWeight.w500,
                                          height: 1.43,
                                        ),
                                      )
                                      : Text(
                                        "( ${_loadingItemsCountController.loadingItemCount.value.toString()} ",
                                        style: TextStyle(
                                          color:Get.find<ThemeController>().isDarkMode.value 
                                              ? AppColor.white : AppColor.black,
                                          fontSize: context.setSp(16),
                                          fontWeight: FontWeight.w500,
                                          height: 1.43,
                                        ),
                                      ),
                                  loadingDataController.isLoadData.value
                                      ? Container()
                                      : Text(
                                        "/ ${loadingDataController.lengthRemote.value} )",
                                        style: TextStyle(
                                          color:Get.find<ThemeController>().isDarkMode.value 
                                              ? AppColor.white : AppColor.black,
                                          fontSize: context.setSp(16),
                                          fontWeight: FontWeight.w500,
                                          height: 1.43,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                          (loadingDataController.isLoad.value)
                              ? SizedBox(
                                width: context.setWidth(454.48),
                                child: LinearProgressIndicator(
                                  color: AppColor.cyanTeal,
                                  borderRadius: BorderRadius.circular(
                                    context.setMinSize(10),
                                  ),
                                ),
                              )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                
              );
            }
          ),
        );
      },
    );
  }
}

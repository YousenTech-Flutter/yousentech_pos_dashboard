// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_enum.dart';
import 'package:shared_widgets/shared_widgets/app_snack_bar.dart';
import 'package:shared_widgets/utils/mac_address_helper.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/utils/define_type_function.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_list.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/domain/dashboard_viewmodel.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';

class CardLoadingdataTablet extends StatefulWidget {
  MapEntry<Loaddata, List> e;

  SideUserMenu? menu;
  Widget? contentpage;
  bool ishide;
  CardLoadingdataTablet(
      {super.key,
      required this.e,
      this.menu,
      this.contentpage,
      this.ishide = false});

  @override
  State<CardLoadingdataTablet> createState() => _CardLoadingdataTabletState();
}

class _CardLoadingdataTabletState extends State<CardLoadingdataTablet> {
  // Map itemdata = loadingDataController.itemdata;

  DashboardController dashboardController =
      Get.put(DashboardController.getInstance());
  LoadingDataController loadingDataController =
      Get.find<LoadingDataController>();
  BuildContext? dialogContext;

  updateSelectedMenu(
      {required SideUserMenu menu, required Widget contentpage}) {
    dashboardController.updateSelectedMenu(sideUserMenu: menu);
    dashboardController.selectedMenulength =
        sideUserMenu[dashboardController.selectedMenu]!.length;
    dashboardController.content = contentpage;
    dashboardController.selectedSubMenu =
        sideUserMenu[dashboardController.selectedMenu]!.isNotEmpty ? 0 : null;
  }

  updatecontent() {
    dashboardController.update(['UserMenu']);
    loadingDataController.update(['loadings']);
    dashboardController.update(['content']);
    loadingDataController.update(['card_loading_data']);
  }

  // Future getsCountLocalAndRemote() async {
  //   await loadingDataController.getitems();
  // }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getsCountLocalAndRemote();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingDataController>(
        id: 'card_loading_data',
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(10.r),
            width: 0.3.sw,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.softIceBlue,
                  blurRadius: 60,
                  offset: const Offset(0, 10),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            widget.e.value.last,
                            clipBehavior: Clip.antiAlias,
                            fit: BoxFit.fill,
                            color: AppColor.darkCyan,
                            width: 15.r,
                            height: 15.r,
                          ),
                          SizedBox(
                            width: 10.r,
                          ),
                          InkWell(
                            onTap: () async {
                              bool isTrustedDevice =
                                  await MacAddressHelper.isTrustedDevice();
                              if (isTrustedDevice) {
                                if (widget.menu != null) {
                                  updateSelectedMenu(
                                      menu: widget.menu!,
                                      contentpage: widget.contentpage!);
                                  updatecontent();
                                }
                              }
                            },
                            child: Text(
                              widget.e.key.name.toString().tr,
                              style: TextStyle(
                                  fontSize: 10.r,
                                  color: AppColor.dimGray,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10.r,
                      // ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: LinearProgress(
                          startNumber:
                              controller.itemdata[widget.e.key.name.toString()]
                                      ?['local'] ??
                                  0,
                          endNumber:
                              controller.itemdata[widget.e.key.name.toString()]
                                      ?['remote'] ??
                                  0,
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<LoadingDataController>(
                    id: 'loading',
                    builder: (controller) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !widget.ishide
                              ? InkWell(
                                  onTap: () async {
                                    loadingDataController.isUpdate.value = true;
                                    bool isTrustedDevice =
                                        await MacAddressHelper
                                            .isTrustedDevice();
                                    if (isTrustedDevice) {
                                      var result =
                                          await synchronizeBasedOnModelType(
                                              type: widget.e.key.toString());

                                      if (result == true) {
                                        appSnackBar(
                                            message: 'synchronized'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      } else if (result == false) {
                                        appSnackBar(
                                            message:
                                                'synchronized_successfully'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      } else if (result is String) {
                                        appSnackBar(
                                          message: result,
                                          messageType:
                                              MessageTypes.connectivityOff,
                                        );
                                      } else {
                                        appSnackBar(
                                            message:
                                                'synchronization_problem'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      }
                                      loadingDataController.isUpdate.value =
                                          false;
                                      controller.update(['card_loading_data']);
                                      controller.update(['loading']);
                                    }
                                    loadingDataController.isUpdate.value =
                                        false;
                                  },
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColor.cyanTeal,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Tooltip(
                                      message: "synchronization".tr,
                                      child: SvgPicture.asset(
                                        'assets/image/sync.svg',
                                        clipBehavior: Clip.antiAlias,
                                        fit: BoxFit.fill,
                                        width: !widget.ishide ? 15.r : 8.r,
                                        height: !widget.ishide ? 15.r : 8.r,
                                        color: AppColor.tealBlue,
                                      ),
                                    ),
                                  ))
                              : Container(),
                          SizedBox(
                            height: 10.r,
                          ),
                          !widget.ishide
                              ? InkWell(
                                  onTap: () async {
                                    var result = await controller.updateAll(
                                        name: widget.e.key.toString());
                                    if (result == true) {
                                      appSnackBar(
                                          message: 'update_success'.tr,
                                          messageType: MessageTypes.success,
                                          isDismissible: false);
                                    } else if (result is String) {
                                      appSnackBar(
                                        message: result,
                                        messageType:
                                            MessageTypes.connectivityOff,
                                      );
                                    } else {
                                      appSnackBar(
                                          message: 'update_Failed'.tr,
                                          messageType: MessageTypes.error,
                                          isDismissible: false);
                                    }
                                    controller.update(['card_loading_data']);
                                  },
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColor.cyanTeal,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      "Update_All".tr,
                                      style: TextStyle(
                                          fontSize: 8.r,
                                          color: AppColor.offWhite,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ))
                              : Container(),
                        ],
                      );
                      // }
                    })
              ],
            ),
          );
        });
  }
}

class Cardloadingdata extends StatefulWidget {
  MapEntry<Loaddata, List> e;

  SideUserMenu? menu;
  Widget? contentpage;
  bool ishide;
  Cardloadingdata(
      {super.key,
      required this.e,
      this.menu,
      this.contentpage,
      this.ishide = false});

  @override
  State<Cardloadingdata> createState() => _CardloadingdataState();
}

class _CardloadingdataState extends State<Cardloadingdata> {
  DashboardController dashboardController =
      Get.put(DashboardController.getInstance());
  LoadingDataController loadingDataController =
      Get.find<LoadingDataController>();
  BuildContext? dialogContext;

  updateSelectedMenu(
      {required SideUserMenu menu, required Widget contentpage}) {
    dashboardController.updateSelectedMenu(sideUserMenu: menu);
    dashboardController.selectedMenulength =
        sideUserMenu[dashboardController.selectedMenu]!.length;
    dashboardController.content = contentpage;
    dashboardController.selectedSubMenu =
        sideUserMenu[dashboardController.selectedMenu]!.isNotEmpty ? 0 : null;
  }

  updatecontent() {
    dashboardController.update(['UserMenu']);
    loadingDataController.update(['loadings']);
    dashboardController.update(['content']);
    loadingDataController.update(['card_loading_data']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingDataController>(
        id: 'card_loading_data',
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(10.r),
            width: 0.2.sw,
            height: 0.2.sh,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10.r),
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
                SvgPicture.asset(
                  widget.e.value.last,
                  package: "yousentech_pos_dashboard",
                  clipBehavior: Clip.antiAlias,
                  fit: BoxFit.fill,
                  width: 15.r,
                  height: 15.r,
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                InkWell(
                  onTap: () async {
                    bool isTrustedDevice =
                        await MacAddressHelper.isTrustedDevice();
                    if (isTrustedDevice) {
                      if (widget.menu != null) {
                        updateSelectedMenu(
                            menu: widget.menu!,
                            contentpage: widget.contentpage!);
                        updatecontent();
                      }
                    }
                  },
                  child: Text(
                    widget.e.key.name.toString().tr,
                    style: TextStyle(
                        fontSize: 10.r,
                        color: AppColor.darkCyan,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 0.015.sh,
                ),
                LinearProgress(
                  startNumber: controller.itemdata[widget.e.key.name.toString()]
                          ?['local'] ??
                      0,
                  endNumber: controller.itemdata[widget.e.key.name.toString()]
                          ?['remote'] ??
                      0,
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                GetBuilder<LoadingDataController>(
                    id: 'loading',
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !widget.ishide
                              ? InkWell(
                                  onTap: () async {
                                    loadingDataController.isUpdate.value = true;
                                    bool isTrustedDevice =
                                        await MacAddressHelper
                                            .isTrustedDevice();
                                    if (isTrustedDevice) {
                                      var result =
                                          await synchronizeBasedOnModelType(
                                              type: widget.e.key.toString());

                                      if (result == true) {
                                        appSnackBar(
                                            message: 'synchronized'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      } else if (result == false) {
                                        appSnackBar(
                                            message:
                                                'synchronized_successfully'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      } else if (result is String) {
                                        appSnackBar(
                                          message: result,
                                          messageType:
                                              MessageTypes.connectivityOff,
                                        );
                                      } else {
                                        appSnackBar(
                                            message:
                                                'synchronization_problem'.tr,
                                            messageType: MessageTypes.success,
                                            isDismissible: false);
                                      }
                                      loadingDataController.isUpdate.value =
                                          false;
                                      controller.update(['card_loading_data']);
                                      controller.update(['loading']);
                                    }
                                    loadingDataController.isUpdate.value =
                                        false;
                                  },
                                  child: Tooltip(
                                    message: "synchronization".tr,
                                    child: SvgPicture.asset(
                                      'assets/image/sync.svg',
                                      clipBehavior: Clip.antiAlias,
                                      fit: BoxFit.fill,
                                      width: !widget.ishide ? 20.r : 8.r,
                                      height: !widget.ishide ? 20.r : 8.r,
                                      color: AppColor.tealBlue,
                                    ),
                                  ))
                              : Container(),
                          !widget.ishide
                              ? InkWell(
                                  onTap: () async {
                                    var result = await controller.updateAll(
                                        name: widget.e.key.toString());
                                    if (result == true) {
                                      appSnackBar(
                                          message: 'update_success'.tr,
                                          messageType: MessageTypes.success,
                                          isDismissible: false);
                                    } else if (result is String) {
                                      appSnackBar(
                                        message: result,
                                        messageType:
                                            MessageTypes.connectivityOff,
                                      );
                                    } else {
                                      appSnackBar(
                                          message: 'update_Failed'.tr,
                                          messageType: MessageTypes.error,
                                          isDismissible: false);
                                    }
                                    controller.update(['card_loading_data']);
                                  },
                                  child: Container(
                                    width: 25.w,
                                    height: 30.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColor.cyanTeal,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      "Update_All".tr,
                                      style: TextStyle(
                                          fontSize: 8.r,
                                          color: AppColor.offWhite,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ))
                              : Container(),
                        ],
                      );
                      // }
                    })
              ],
            ),
          );
        });
  }
}

class LinearProgress extends StatefulWidget {
  final int startNumber;
  final int endNumber;
  const LinearProgress({
    super.key,
    required this.startNumber,
    required this.endNumber,
  });
  @override
  State<LinearProgress> createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress> {
  @override
  void initState() {
    if (widget.startNumber == 0 && widget.endNumber == 0) {
      _progress = 0;
    } else if (widget.endNumber == 0) {
      _progress = 0;
    } else {
      _progress =
          (widget.startNumber.toDouble() / widget.endNumber.toDouble()) * 100;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LinearProgress oldWidget) {
    _progress = (widget.startNumber > widget.endNumber)
        ? (widget.endNumber /
                (widget.startNumber == 0 ? 1 : widget.startNumber)) *
            100
        : (widget.startNumber /
                (widget.endNumber == 0 ? 1 : widget.endNumber)) *
            100;
    super.didUpdateWidget(oldWidget);
  }

  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${'synchronization'.tr} : ',
                style: TextStyle(
                    fontSize: 10.r,
                    color: AppColor.gray,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
              // get the number
              TextSpan(
                text: ' ${_progress.toInt()} % ',
                style: TextStyle(
                    fontSize: 10.r,
                    color: AppColor.gunmetalGray,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.01.sh,
        ),
        LinearProgressIndicator(
            value: (_progress),
            minHeight: 5.r,
            color: AppColor.emeraldGreen,
            backgroundColor: AppColor.lightGray,
            borderRadius: BorderRadius.circular(10.r)),
      ],
    );
  }
}

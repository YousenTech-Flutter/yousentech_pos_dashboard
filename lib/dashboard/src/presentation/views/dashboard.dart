// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pos_shared_preferences/helper/app_enum.dart';
import 'package:pos_shared_preferences/models/final_report_info.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_enums.dart';
import 'package:shared_widgets/config/app_images.dart';
import 'package:shared_widgets/config/app_theme.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/app_snack_bar.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/utils/define_type_function.dart';
import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/config/app_enums.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_service.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/presentation/close_session.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  LoadingDataController loadingDataController = Get.put(
    LoadingDataController(),
  );
  late final SessionController sessionController;
  final FinalReportController finalReportController =
      Get.isRegistered<FinalReportController>()
          ? Get.find<FinalReportController>()
          : Get.put(FinalReportController());
  // int _salesTab = 0; // 0: daily, 1: monthly, 2: yearly
  List<String> salesTitals = ["weekly", "monthly", "yearly"];
  Future posSessionsData() async {
    await sessionController.posSessionsData();
    await loadingDataController.getitems();
    await sessionController.sessionAmountOpration();
    await finalReportController.getFinalReportInfo(dateFilterKey: '');
    await finalReportController.getSalesPerformanceInfo();
    return sessionController.posSessionsList;
  }

  @override
  void initState() {
    super.initState();
    sessionController = Get.put(SessionController());
    posSessionsData();
    SessionService.sessionServiceInstance = null;
    SessionService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.setHeight(16),
            bottom: context.setHeight(5),
            right: context.setWidth(20.5),
            left: context.setWidth(20.5),
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: context.setHeight(16),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: context.setWidth(16),
                  children: [
                    Expanded(
                      flex: 3,
                      child: GetBuilder<SessionController>(
                        id: "Sessionbutton",
                        builder: (sessioncontroller) {
                          return Column(
                            spacing: context.setHeight(16),
                            children: [
                              GetBuilder<SessionController>(
                                id: "session_amount_opration_card",
                                builder: (controller) {
                                  return PosCard(sessionController: sessioncontroller);
                                }
                              ),
                              GetBuilder<FinalReportController>(
                                id: "session_card",
                                builder: (controller) {
                                  return PaymentDataCard(
                                    finalReportController:
                                        finalReportController,
                                  );
                                },
                              ),
                              GetBuilder<FinalReportController>(
                                id: "session_card",
                                builder: (controller) {
                                  return BestSellingProducts(
                                    finalReportController:
                                        finalReportController,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        spacing: context.setHeight(16),
                        children: [
                          Row(
                            spacing: context.setWidth(16),
                            children: [
                              Expanded(
                                child: GetBuilder<LoadingDataController>(
                                  id: 'card_loading_data',
                                  builder: (controller) {
                                    int remote =
                                        loadingDataController.itemdata[Loaddata
                                            .customers
                                            .name
                                            .toString()]["remote"];
                                    int local =
                                        loadingDataController.itemdata[Loaddata
                                            .customers
                                            .name
                                            .toString()]["local"];
                                    return ProductAndCustomerCard(
                                      loadingDataController:
                                          loadingDataController,
                                      image:AppImages.partner,
                                      title: 'customers',
                                      syncData:
                                          remote == 0
                                              ? "0"
                                              : local > remote
                                              ? (remote /
                                                      (local == 0 ? 1 : local) *
                                                      100)
                                                  .toStringAsFixed(0)
                                              : ((local / remote) * 100)
                                                  .toStringAsFixed(0),
                                      remoteAndLocalCount: "$remote / $local",
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: GetBuilder<LoadingDataController>(
                                  id: 'card_loading_data',
                                  builder: (controller) {
                                    int remote =
                                        loadingDataController.itemdata[Loaddata
                                            .products
                                            .name
                                            .toString()]["remote"];
                                    int local =
                                        loadingDataController.itemdata[Loaddata
                                            .products
                                            .name
                                            .toString()]["local"];
                                    return ProductAndCustomerCard(
                                      loadingDataController:
                                          loadingDataController,
                                      image:AppImages.product,
                                      title: "products",
                                      syncData:
                                          remote == 0
                                              ? "0"
                                              : local > remote
                                              ? (remote /
                                                      (local == 0 ? 1 : local) *
                                                      100)
                                                  .toStringAsFixed(0)
                                              : ((local / remote) * 100)
                                                  .toStringAsFixed(0),
                                      remoteAndLocalCount: "$remote / $local",
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<FinalReportController>(
                            id: "session_card",
                            builder: (controller) {
                              return Row(
                                spacing: context.setWidth(16),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AmountTotalCard(
                                      title: InfoTotalCard.totalSales.text.tr,
                                      total: controller.formatter.format(
                                        controller
                                                .finalReportInfo
                                                ?.totalOutInvoice ??
                                            0.0,
                                      ),
                                      image:AppImages.div2,
                                      color: const Color(0xFF27AE60),
                                    ),
                                  ),
                                  Expanded(
                                    child: AmountTotalCard(
                                      title: InfoTotalCard.netIncome.text.tr,
                                      total: controller.formatter.format(
                                        controller.finalReportInfo?.netSales ??
                                            0.0,
                                      ),
                                      image: AppImages.div1,
                                      color: const Color(0x1916A6B7),
                                    ),
                                  ),
                                  Expanded(
                                    child: AmountTotalCard(
                                      title: InfoTotalCard.totalReturns.text.tr,
                                      total: controller.formatter.format(
                                        controller
                                                .finalReportInfo
                                                ?.totalOutRefund ??
                                            0.0,
                                      ),
                                      image:AppImages.div,
                                      color: const Color(0xFFF2AC57),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          GetBuilder<FinalReportController>(
                            id: "sales_performance",
                            builder: (controller) {
                              return Obx(() {
      return Container(
                                    decoration: ShapeDecoration(
                                      color:Theme.of(context).extension<CustomTheme>()!.preferredSizeBackground,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color:
                                              Get.find<ThemeController>().isDarkMode.value
                                                  ? Colors.white.withValues(
                                                    alpha: 0.50,
                                                  )
                                                  : const Color(0xFFE7E7E8),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          context.setMinSize(16),
                                        ),
                                      ),
                                    ),
                                    height: context.setHeight(291.77),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: context.setHeight(13.5),
                                        horizontal: context.setWidth(20.93),
                                      ),
                                      child: Column(
                                        spacing: context.setHeight(10),
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                // height: context.setHeight(39),
                                                // width: context.setWidth(249.06),
                                                decoration: ShapeDecoration(
                                                  color:Theme.of(context).colorScheme.onPrimary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          context.setMinSize(14.77),
                                                        ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: context.setWidth(
                                                      10,
                                                    ),
                                                    vertical: context.setHeight(7),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ...salesTitals.map(
                                                        (e) => InkWell(
                                                          onTap: () async {
                                                            await controller
                                                                .updateSalesPerformanceTab(
                                                                  type: salesTitals
                                                                      .indexOf(e),
                                                                );
                                                          },
                                                          child: Container(
                                                            height: context
                                                                .setHeight(27),
                                                            decoration:
                                                                salesTitals.indexOf(
                                                                          e,
                                                                        ) ==
                                                                        controller
                                                                            .salesPerformanceTab
                                                                    ? ShapeDecoration(
                                                                      color:Theme.of(context).colorScheme.onPrimary,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          width: 1,
                                                                          color:Theme.of(context).colorScheme.onPrimary,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              8,
                                                                            ),
                                                                      ),
                                                                    )
                                                                    : null,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        context
                                                                            .setWidth(
                                                                              19.1,
                                                                            ),
                                                                  ),
                                                              child: Obx(() {
                                        return Center(
                                                                    child: Text(
                                                                      e.tr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                        color:
                                                                            salesTitals.indexOf(
                                                                                      e,
                                                                                    ) ==
                                                                                    controller.salesPerformanceTab
                                                                                ? Get.find<ThemeController>().isDarkMode.value
                                                                                    ? Colors.white
                                                                                    : const Color(
                                                                                      0xFF01343A,
                                                                                    )
                                                                                : const Color(
                                                                                  0xFF898989,
                                                                                ),
                                                                        fontSize:
                                                                            context
                                                                                .setSp(
                                                                                  14,
                                                                                ),
                                                                        fontFamily:
                                                                            'Tajawal',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        height: 1.14,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'sales_performance'.tr,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: context.setSp(16),
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.50,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: context.setWidth(16),
                                                vertical: context.setHeight(16),
                                              ),
                                              child: LayoutBuilder(
                                                builder: (context, boxConstraints) {
                                                  return SizedBox(
                                                    height:
                                                        boxConstraints.maxHeight,
                                                    child: _SalesLineChart(
                                                      tab:
                                                          controller
                                                              .salesPerformanceTab,
                                                      finalReportController:
                                                          finalReportController,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                          GetBuilder<FinalReportController>(
                            id: "session_card",
                            builder: (controller) {
                              return BestSellingCategoriesChart(
                                finalReportController: finalReportController,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (sessionController.isLoading.value ||
              loadingDataController.isUpdate.value) {
            return LoadingWidget(message: sessionController.message.value);
          } else {
            return Container(); // Return an empty widget when not loading
          }
        }),
      ],
    );
  }
}

class AmountTotalCard extends StatelessWidget {
  String title;
  Color color;
  String image;
  String total;

  AmountTotalCard({
    Key? key,
    required this.title,
    required this.color,
    required this.image,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: context.setHeight(97),
          decoration: ShapeDecoration(
            color:  Theme.of(context).extension<CustomTheme>()!.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Theme.of(context).extension<CustomTheme>()!.cardBorderColor,
                // color:
                //     Get.find<ThemeController>().isDarkMode.value
                //         ? Colors.white.withValues(alpha: 0.50)
                //         : const Color(0xFFE7E7E8),
              ),
              borderRadius: BorderRadius.circular(context.setMinSize(16)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setWidth(16),
              vertical: context.setHeight(Platform.isWindows ? 10 : 16),
            ),
            child: Row(
              spacing: context.setWidth(10),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  image,
                  package: 'shared_widgets',
                  width: context.setWidth(50),
                  height: context.setHeight(50),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: context.setHeight(10),
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: context.setSp(16),
                        fontWeight: FontWeight.w500,
                        height: 1.67,
                      ),
                    ),
                    Row(
                      spacing: context.setWidth(5),
                      children: [
                        Text(
                          total,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.setSp(18),
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w700,
                            height: 1.78,
                          ),
                        ),
                        SvgPicture.asset(
                          AppImages.riyal,
                          package: 'shared_widgets',
                          width: context.setWidth(12.2),
                          height: context.setHeight(12.2),
                          color:Theme.of(context).colorScheme.onSurface,
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

class ProductAndCustomerCard extends StatelessWidget {
  String image;
  String title;
  String syncData;
  String remoteAndLocalCount;
  LoadingDataController loadingDataController;
  ProductAndCustomerCard({
    super.key,
    required this.image,
    required this.title,
    required this.syncData,
    required this.remoteAndLocalCount,
    required this.loadingDataController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          height: context.setHeight(215),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color:Theme.of(context).extension<CustomTheme>()!.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color:Theme.of(context).extension<CustomTheme>()!.cardBorderColor,
                // Colors.white.withValues(alpha: 0.50),
              ),
              borderRadius: BorderRadius.circular(context.setMinSize(20)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: context.setWidth(40),
                    height: context.setHeight(40),
                    decoration: ShapeDecoration(
                      color:
                          Get.find<ThemeController>().isDarkMode.value
                              ? const Color(0x1918BBCD)
                              : const Color(0x1916A6B7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.setMinSize(11),
                        ),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        image,
                        package: 'shared_widgets',
                        width: context.setWidth(17),
                        height: context.setHeight(27),
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColor.appColor,
                        fontSize: context.setSp(14),
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                        height: 1.27,
                      ),
                      children: [
                        TextSpan(text: remoteAndLocalCount.split("/").first),
                        TextSpan(
                          text: '/',
                          style: TextStyle(color: const Color(0xFF4B5563)),
                        ),
                        TextSpan(
                          text: remoteAndLocalCount.split("/").last,
                          style: TextStyle(color: const Color(0xFFF2AC57)),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   remoteAndLocalCount,
                  //   style: TextStyle(
                  //     color: AppColor.appColor,
                  //     fontSize: context.setSp(14),
                  //     fontFamily: 'Tajawal',
                  //     fontWeight: FontWeight.w700,
                  //     height: 1.27,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: context.setHeight(8)),
              Text(
                title.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.setSp(18),
                  fontWeight: FontWeight.w700,
                  height: 1.56,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Sync: $syncData %',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color:Theme.of(context).textTheme.labelSmall!.color,
                      fontSize: context.setSp(14),
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.setHeight(8)),
              SizedBox(
                width: context.screenWidth,
                height: context.setHeight(8),
                child: LinearProgressIndicator(
                  value: double.parse(syncData) / 100,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(9999),
                  backgroundColor:
                      Get.find<ThemeController>().isDarkMode.value
                          ? const Color(0x26F7F7F7)
                          : const Color(0x268B8B8B),
                  color:AppColor.appColor,
                ),
              ),
              SizedBox(height: context.setHeight(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SyncButton(
                    isHaveBackColor: true,
                    title: "Update_All".tr,
                    titleColor:  Get.find<ThemeController>().isDarkMode.value
                                  ? const Color(0xFF042B2F)
                                  : Colors.white,
                    onTap: () async {
                      var result = await loadingDataController.updateAll(
                        name: title=="products" ?Loaddata.products.toString() :Loaddata.customers.toString(),
                      );
                      if (result == true) {
                        appSnackBar(
                          message: 'update_success'.tr,
                          messageType: MessageTypes.success,
                          isDismissible: false,
                        );
                      } else if (result is String) {
                        appSnackBar(
                          message: result,
                          messageType: MessageTypes.connectivityOff,
                        );
                      } else {
                        appSnackBar(
                          message: 'update_Failed'.tr,
                          messageType: MessageTypes.error,
                          isDismissible: false,
                        );
                      }
                      loadingDataController.update(['card_loading_data']);
                    },
                  ),
                  Tooltip(
                    message: "synchronization".tr,
                    child: SyncButton(
                      isHaveBackColor: false,
                      title: '',
                      titleColor: Get.find<ThemeController>().isDarkMode.value
                                  ? const Color(0xFF042B2F)
                                  : Colors.white,
                      onTap: () async {
                        loadingDataController.isUpdate.value = true;
                        var result = await synchronizeBasedOnModelType(type: title=="products" ?Loaddata.products.toString() :Loaddata.customers.toString() );
                        if (result == true) {
                          appSnackBar(
                            message: 'synchronized'.tr,
                            messageType: MessageTypes.success,
                            isDismissible: false,
                          );
                        } else if (result == false) {
                          appSnackBar(
                            message: 'synchronized_successfully'.tr,
                            messageType: MessageTypes.success,
                            isDismissible: false,
                          );
                        } else if (result is String) {
                          appSnackBar(
                            message: result,
                            messageType: MessageTypes.connectivityOff,
                          );
                        } else {
                          appSnackBar(
                            message: 'synchronization_problem'.tr,
                            isDismissible: false,
                          );
                        }
                        loadingDataController.isUpdate.value = false;
                        loadingDataController.update(['card_loading_data']);
                        loadingDataController.update(['loading']);

                        loadingDataController.isUpdate.value = false;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SyncButton extends StatelessWidget {
  bool isHaveBackColor;
  String title;
  Color titleColor;
  void Function()? onTap;
  SyncButton({
    required this.isHaveBackColor,
    required this.title,
    required this.onTap,
    required this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
            height: context.setHeight(38.91),
            width:
                isHaveBackColor ? context.setWidth(139) : context.setWidth(56.20),
            decoration: ShapeDecoration(
              color: isHaveBackColor ? AppColor.appColor : null,
              shape: RoundedRectangleBorder(
                side:
                    isHaveBackColor
                        ? BorderSide.none
                        : BorderSide(width: 1.01, color: const Color(0xFF898383)),
                borderRadius: BorderRadius.circular(context.setMinSize(30.54)),
              ),
              shadows:
                  isHaveBackColor
                      ? [
                        BoxShadow(
                          color: Color(0x3316A6B7),
                          blurRadius: 30,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ]
                      : [],
            ),
            child:
                isHaveBackColor
                    ? Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:titleColor,
                              
                          fontSize: context.setSp(15.13),
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    )
                    : Center(
                      child: SvgPicture.asset(
                        AppImages.syncImage2,
                        package: 'shared_widgets',
                        // width: context.setWidth(16.86),
                        // height: context.setHeight(17.75),
                      ),
                    ),
          )
       
    );
  }
}

class PosCard extends StatefulWidget {
  SessionController sessionController;
  PosCard({Key? key, required this.sessionController}) : super(key: key);

  @override
  State<PosCard> createState() => _PosCardState();
}

class _PosCardState extends State<PosCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
          height: context.setHeight(215),
          decoration: ShapeDecoration(
            color:Theme.of(context).extension<CustomTheme>()!.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color:Theme.of(context).extension<CustomTheme>()!.cardBorderColor,
                //  Colors.white.withValues(alpha: 0.50),
              ),
              borderRadius: BorderRadius.circular(context.setMinSize(20)),
            ),
          ),
        
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.setHeight(24),
              horizontal: context.setWidth(24),
            ),
            child: Column(
              spacing: context.setHeight(6),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: context.setWidth(8),
                      children: [
                        SvgPicture.asset(
                          AppImages.pos,
                          package: 'shared_widgets',
                          width: context.setWidth(24),
                          height: context.setHeight(24),
                        ),
                        SizedBox(
                          width: context.setWidth(198.75),
                          child: Text(
                            SharedPr.currentPosObject!.name.toString(),
                            style: TextStyle(
                              fontSize: context.setSp(20),
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: context.setWidth(8),
                      children: [
                        Text(
                          widget.sessionController.sessionAmountOprationCard.isEmpty
                              ? "0.0"
                              : 
                              widget.sessionController.formatter.format(
                                widget
                                        .sessionController
                                        .sessionAmountOprationCard["session_amount_opration"]["total_out_invoice"] ??
                                    0.0,
                              ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.setSp(20),
                            fontWeight: FontWeight.w600,
                            height: 1.56,
                          ),
                        ),
                        SvgPicture.asset(
                          AppImages.riyal,
                          package: 'shared_widgets',
                          width: context.setWidth(13),
                          height: context.setHeight(13),
                          color:Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: context.setWidth(8),
                      children: [
                        SvgPicture.asset(
                          AppImages.data,
                          package: 'shared_widgets',
                          width: context.setWidth(18),
                          height: context.setHeight(18),
                        ),
                        Text.rich(
                          style: TextStyle(
                            fontSize: context.setSp(context.setSp(14)),
                            fontWeight: FontWeight.w400,
                            height: 2.50,
                          ),
                          TextSpan(
                            children: [
                              // TextSpan(text: "date_time".tr),
                              // TextSpan(text: '  :   '),
                              TextSpan(
                                text:
                                    widget
                                                .sessionController
                                                .posSessionsList
                                                .isEmpty ||
                                            widget
                                                    .sessionController
                                                    .posSessionsList
                                                    .last
                                                    .startTime ==
                                                ''
                                        ? formatDateTime(null)
                                        : formatDateTime(
                                          widget
                                              .sessionController
                                              .posSessionsList
                                              .last
                                              .startTime!,
                                        ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
        
                    Text(
                      'total_sales'.tr,
                      style: TextStyle(
                        fontSize: context.setSp(14),
                        fontWeight: FontWeight.w400,
                        height: 2.50,
                      ),
                    ),
                  ],
                ),
        
                Spacer(),
                if (widget.sessionController.posSessionsList.isEmpty ||
                    widget.sessionController.posSessionsList.last.state ==
                        SessionState.closedSession) ...[
                  ButtonsToContinueOrStop(
                    onTap: () {
                      widget.sessionController.sessionStartOrResumOnTap(context: context);
                    },
                    image: AppImages.stop,
                    data: "startNewSession".tr,
                    addBorderSide: false,
                    color: const Color(0xFFF2AC57),
                  ),
                ],
                if (widget.sessionController.posSessionsList.isNotEmpty &&
                    widget.sessionController.posSessionsList.last.state ==
                        SessionState.openSession) ...[
                  Row(
                    spacing: context.setWidth(9.7),
                    children: [
                      if (widget.sessionController
                          .checkStartOrResumeSessionAppearance()) ...[
                        Expanded(
                          // flex: 3,
                          child: ButtonsToContinueOrStop(
                            onTap: () {
                              widget.sessionController.sessionStartOrResumOnTap(context: context,);
                            },
                            image:AppImages.stop,
                            data: "ResumeSession".tr,
                            addBorderSide: false,
                            color: const Color(0xFFF2AC57),
                          ),
                        ),
                      ],
                      Expanded(
                        // flex:
                        //     !widget.sessionController
                        //             .checkStartOrResumeSessionAppearance()
                        //         ? 3
                        //         : 2,
                        child: ButtonsToContinueOrStop(
                          onTap: () async {
                            widget.sessionController.isLoading.value = true;
                            await widget.sessionController.uploadData();
                            widget.sessionController.isLoading.value = false;
                            Get.to(() => CloseSession());
                          },
                          image:AppImages.continueImage,
                          data: "closeSession".tr,
                          addBorderSide: true,
                          color: const Color(0x2BF20C10),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      
  }
}

class ButtonsToContinueOrStop extends StatelessWidget {
  Color? color;
  String image;
  String data;
  bool addBorderSide;
  void Function()? onTap;
  ButtonsToContinueOrStop({
    super.key,
    this.color,
    this.addBorderSide = false,
    required this.data,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
            height: context.setHeight(46),
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                side:
                    addBorderSide
                        ? BorderSide(
                          width: 1,
                          color:
                              Get.find<ThemeController>().isDarkMode.value
                                  ? Colors.black.withValues(alpha: 0.17)
                                  : Colors.white.withValues(alpha: 0.50),
                        )
                        : BorderSide.none,
                borderRadius: BorderRadius.circular(context.setMinSize(9)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.setWidth(5),
              children: [
                SvgPicture.asset(
                  image,
                  package: 'shared_widgets',
                  width: context.setWidth(28.5),
                  height: context.setHeight(28.5),
                  color:
                      addBorderSide
                          ? Get.find<ThemeController>().isDarkMode.value
                              ? const Color(0xFFF68889)
                              : const Color(0xFFE94043)
                          : AppColor.black,
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.setHeight(4.3)),
                  child: Center(
                    child: Text(
                      data,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            addBorderSide
                                ? Get.find<ThemeController>().isDarkMode.value
                                    ? const Color(0xFFF68889)
                                    : const Color(0xFFE94043)
                                : const Color(0xFF032A2E),
                        fontSize: context.setSp(16.10),
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
       
    );
  }
}

String formatDateTime(String? odooDateTime) {
  // 1. نحول النص القادم من Odoo إلى DateTime
  DateTime date =
      odooDateTime == null || odooDateTime == ''
          ? DateTime.now()
          : DateTime.parse(odooDateTime);

  // 2. ننسق التاريخ حسب اللغة
  String formattedDate = intl.DateFormat(
    "d MMMM y",
    SharedPr.lang,
  ).format(date);

  // 3. ننسق الوقت حسب اللغة
  String formattedTime = intl.DateFormat("h:mm a", SharedPr.lang).format(date);

  return " $formattedDate   –   $formattedTime";
}

class _SalesLineChart extends StatefulWidget {
  FinalReportController finalReportController;
  final int tab; // 0: daily, 1: monthly, 2: yearly
  _SalesLineChart({
    Key? key,
    required this.finalReportController,
    required this.tab,
  }) : super(key: key);

  @override
  State<_SalesLineChart> createState() => _SalesLineChartState();
}

class _SalesLineChartState extends State<_SalesLineChart> {
  List<FlSpot> get _spots {
    return widget.finalReportController.salesPerformanceItems
        .asMap()
        .entries
        .map(
          (entry) =>
              FlSpot(entry.key.toDouble(), (entry.value["total"]).toDouble()),
        )
        .toList();
  }

  List get bottomTitles {
    return widget.finalReportController.salesPerformanceItems
        .map((item) => item["name"])
        .toList();
  }

  double get maxY {
    final totals = widget.finalReportController.salesPerformanceItems.map(
      (e) => e["total"] as num,
    );
    return totals.isNotEmpty
        ? totals.reduce((a, b) => a > b ? a : b).toDouble()
        : 10;
  }

  double get minY {
    final totals = widget.finalReportController.salesPerformanceItems.map(
      (e) => e["total"] as num,
    );
    return totals.isNotEmpty
        ? totals.reduce((a, b) => a < b ? a : b).toDouble()
        : 0;
  }

  // double? minY = 0;
  // double? maxY = 10;
  @override
  void initState() {
    // var totals = widget.finalReportController.salesPerformanceItems.map(
    //   (e) => e["total"] as num,
    // );
    // if (totals.isNotEmpty) {
    //   // أكبر قيمة
    //   maxY = totals.reduce((a, b) => a > b ? a : b).toDouble();

    //   // أصغر قيمة
    //   minY = totals.reduce((a, b) => a < b ? a : b).toDouble();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: context.setWidth(40),
                  getTitlesWidget: (v, meta) {
                    // احسب كل قيمة تريدها بناءً على maxY
                    final interval = calculateYInterval(maxY); // دالة اللي سويناها
                    if (v % interval != 0) return const SizedBox.shrink();
                    return Text(
                      v.toInt().toString(),
                      style: TextStyle(
                        // color:
                            // Get.find<ThemeController>().isDarkMode.value
                            //     ? Color(0xFFB1B3BC)
                            //     : const Color(0xFF01343A),
                        fontSize: context.setSp(12.30),
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (v, meta) {
                    final index = v.toInt();
                    if (index >= 0 && index < bottomTitles.length) {
                      return Text(
                        bottomTitles[index],
                        style: TextStyle(
                          // color:
                          //     Get.find<ThemeController>().isDarkMode.value
                          //         ? Color(0xFFB1B3BC)
                          //         : const Color(0xFF01343A),
                          fontSize: context.setSp(12.30),
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // ما يعرض شيء
                    }
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: bottomTitles.length - 1,
            minY: minY,
            maxY: maxY,
            lineBarsData: [
              LineChartBarData(
                spots: _spots,
                isCurved: false,
                barWidth: 6,
                color: AppColor.appColor,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.appColor,
                      Get.find<ThemeController>().isDarkMode.value
                          ? const Color(0x00241E1E)
                          : Colors.white.withValues(alpha: 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        );
     
  }
}

class BestSellingProducts extends StatelessWidget {
  FinalReportController finalReportController;
  BestSellingProducts({Key? key, required this.finalReportController})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BasedSellingProduct> products =
        finalReportController.finalReportInfo == null
            ? []
            : finalReportController.finalReportInfo!.basedSellingProduct ?? [];

    final colors = [
      const Color(0xFF0097A7),
      const Color(0xFFFBC02D),
      const Color(0xFF757575),
    ];
    double total = 0;
    if (products.isNotEmpty) {
      products.sort(
        (a, b) => ((b.totalPrice) as double).compareTo(a.totalPrice!),
      );
      total = products.fold<double>(0, (sum, p) => sum + (p.totalPrice!));
    }
    return  Container(
          width: context.screenWidth,
          height: context.setHeight(123.7),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color:Theme.of(context).extension<CustomTheme>()!.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color:Theme.of(context).extension<CustomTheme>()!.cardBorderColor,
              ),
              borderRadius: BorderRadius.circular(context.setMinSize(16)),
            ),
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, boxConstraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: context.setHeight(16),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'best_selling_products'.tr,
                        style: TextStyle(
                          fontSize: context.setSp(15.36),
                          fontWeight: FontWeight.w700,
                          height: 1.23,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          spacing: context.setWidth(7.75),
                          children:
                              products.map((p) {
                                final value = p.totalPrice!;
                                final color =
                                    colors[products.indexOf(p) % colors.length];
                                final flex =
                                    ((value / total) * boxConstraints.maxWidth);
                                return Container(
                                  width: flex,
                                  height: context.setHeight(11),
                                  decoration: ShapeDecoration(
                                    color: color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        context.setMinSize(12.72),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      Row(
                        spacing: context.setWidth(23),
                        children: [
                          ...products.map(
                            (p) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.getProductNameBasedOnLang,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: context.setSp(11.55),
                                    fontWeight: FontWeight.w500,
                                    height: 1.23,
                                  ),
                                ),
                                Row(
                                  spacing: context.setWidth(10),
                                  children: [
                                    Text(
                                      (p.totalPrice).toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: context.setSp(14.85),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 1.33,
                                      ),
                                    ),
                                    Container(
                                      width: context.setWidth(20),
                                      height: context.setHeight(6),
                                      decoration: ShapeDecoration(
                                        color:
                                            colors[products.indexOf(p) %
                                                colors.length],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6.60),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
     
  }
}

class BestSellingCategoriesChart extends StatefulWidget {
  FinalReportController finalReportController;
  BestSellingCategoriesChart({Key? key, required this.finalReportController})
    : super(key: key);

  @override
  State<BestSellingCategoriesChart> createState() =>
      _BestSellingCategoriesChartState();
}

class _BestSellingCategoriesChartState
    extends State<BestSellingCategoriesChart> {
  List<Color> colorList = [
    AppColor.appColor,
    const Color(0xFFFFC300),
    const Color(0xFF8DD3C7),
  ];
  double get totalQtyAll {
  return widget.finalReportController.finalReportInfo != null &&
        widget
            .finalReportController
            .finalReportInfo!
            .productBasedCategories!
            .isNotEmpty
      ? widget
          .finalReportController
          .finalReportInfo!
          .productBasedCategories!
          .fold(0.0, (sum, item) => sum + item.totalQty!)
      : 0.0;
}



  // double totalQtyAll = 0.0;
  @override
  void initState() {
    super.initState();
    // if (widget.finalReportController.finalReportInfo != null &&
    //     widget
    //         .finalReportController
    //         .finalReportInfo!
    //         .productBasedCategories!
    //         .isNotEmpty) {
    //   totalQtyAll = widget
    //       .finalReportController
    //       .finalReportInfo!
    //       .productBasedCategories!
    //       .fold(0.0, (sum, item) => sum + item.totalQty!);
    // }
    // print(
    //   "${widget.finalReportController.finalReportInfo!.productBasedCategories!}",
    // );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          height:
            Platform.isWindows ? context.setHeight(257) :  widget.finalReportController.finalReportInfo != null &&
                      widget
                          .finalReportController
                          .finalReportInfo!
                          .productBasedCategories!
                          .isNotEmpty
                  ? null
                  : 
                  context.setHeight(257),
          decoration: ShapeDecoration(
            color:Theme.of(context).extension<CustomTheme>()!.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color:Theme.of(context).extension<CustomTheme>()!.cardBorderColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setWidth(16),
              vertical: context.setHeight(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'best_product_by_cat'.tr,
                    style: TextStyle(
                      fontSize: context.setSp(16),
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ),
                if (widget.finalReportController.finalReportInfo != null &&
                    widget
                        .finalReportController
                        .finalReportInfo!
                        .productBasedCategories!
                        .isNotEmpty) ...[
                  // Chart + Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Legend
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...widget
                              .finalReportController
                              .finalReportInfo!
                              .productBasedCategories!
                              .map(
                                (item) => _legendItem(
                                  text: item.getProductNameBasedOnLang,
                                  color:
                                      colorList[widget
                                              .finalReportController
                                              .finalReportInfo!
                                              .productBasedCategories!
                                              .indexOf(item) %
                                          colorList.length],
                                  context: context,
                                  percentage:
                                      totalQtyAll == 0
                                          ? 0
                                          : ((item.totalQty! / totalQtyAll) * 100)
                                              .roundToDouble(),
                                ),
                              ),
                        ],
                      ),
                      // Pie Chart (Donut)
                      SizedBox(
                        width: context.setWidth(300),
                        height: context.setHeight(150),
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: context.setWidth(3.9),
                            // centerSpaceRadius:context.setWidth(40),
                            sections: [
                              ...widget
                                  .finalReportController
                                  .finalReportInfo!
                                  .productBasedCategories!
                                  .map(
                                    (item) => PieChartSectionData(
                                      value:
                                          totalQtyAll == 0
                                              ? 0
                                              : ((item.totalQty! / totalQtyAll) *
                                                      100)
                                                  .roundToDouble(),
                                      color:
                                          colorList[widget
                                                  .finalReportController
                                                  .finalReportInfo!
                                                  .productBasedCategories!
                                                  .indexOf(item) %
                                              colorList.length],
                                      radius: context.setMinSize(33.5),
                                      showTitle: false,
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      
  }
}

// Legend item widget
Widget _legendItem({
  required String text,
  required Color color,
  required BuildContext context,
  required double percentage,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: context.setHeight(10)),
    child: Row(
      spacing: context.setWidth(10),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.setWidth(30),
          height: context.setHeight(13),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(context.setMinSize(10)),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xFF6E6E6E),
            fontSize: context.setSp(14),
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w400,
            height: 0.71,
          ),
        ),
        Text(
          "$percentage %",
          style: TextStyle(
            color: const Color(0xFF6E6E6E),
            fontSize: context.setSp(14),
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w400,
            height: 0.71,
          ),
        ),
      ],
    ),
  );
}

double calculateYInterval(double maxY) {
  if (maxY <= 10) return 1;
  if (maxY <= 50) return 5;
  if (maxY <= 100) return 10;
  if (maxY <= 500) return 50;
  if (maxY <= 1000) return 100;
  // لو أكبر من كذا نقدر نعمل خطوة أكبر
  return (maxY / 10).ceilToDouble(); // 10 خطوات تقريبية
}

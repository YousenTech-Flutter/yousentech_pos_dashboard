// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_enums.dart';
import 'package:shared_widgets/config/app_images.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/app_snack_bar.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/utils/define_type_function.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/domain/dashboard_viewmodel.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/dashboard.dart';
import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/config/app_enums.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_service.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/presentation/close_session.dart';

class DashboardMobile extends StatefulWidget {
  DashboardMobile({super.key});
  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  LoadingDataController loadingDataController = Get.put(
    LoadingDataController(),
  );
  late final SessionController sessionController;
  final FinalReportController finalReportController =
      Get.isRegistered<FinalReportController>()
          ? Get.find<FinalReportController>()
          : Get.put(FinalReportController());
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

  final pageController = PageController(viewportFraction: 1.0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.setHeight(16),
            bottom: context.setHeight(5),
            right: context.setWidth(10),
            left: context.setWidth(10),
          ),
          child: Column(
            spacing: context.setHeight(10),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<SessionController>(
                id: "Sessionbutton",
                builder: (sessioncontroller) {
                  return Column(
                    spacing: context.setHeight(16),
                    children: [
                      GetBuilder<SessionController>(
                          id: "session_amount_opration_card",
                          builder: (controller) {
                            return PosCard(
                                sessionController: sessioncontroller);
                          }),
                    ],
                  );
                },
              ),
              GetBuilder<LoadingDataController>(
                id: 'card_loading_data',
                builder: (controller) {
                  int customerRemote = loadingDataController.itemdata.isEmpty
                      ? 0
                      : loadingDataController
                              .itemdata[Loaddata.customers.name.toString()]
                          ["remote"];
                  int customerLocal = loadingDataController.itemdata.isEmpty
                      ? 0
                      : loadingDataController
                              .itemdata[Loaddata.customers.name.toString()]
                          ["local"];
                  int productRemote = loadingDataController.itemdata.isEmpty
                      ? 0
                      : loadingDataController
                              .itemdata[Loaddata.products.name.toString()]
                          ["remote"];
                  int productLocal = loadingDataController.itemdata.isEmpty
                      ? 0
                      : loadingDataController
                              .itemdata[Loaddata.products.name.toString()]
                          ["local"];
                  return Container(
                    // height: context.setHeight(100),
                    decoration: ShapeDecoration(
                      color: Get.find<ThemeController>().isDarkMode.value
                          ? Colors.black.withValues(alpha: 0.17)
                          : Colors.white.withValues(alpha: 0.50),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Get.find<ThemeController>().isDarkMode.value
                              ? Colors.white.withValues(alpha: 0.50)
                              : const Color(0xFFE7E7E8),
                        ),
                        borderRadius:
                            BorderRadius.circular(context.setMinSize(20)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.setHeight(24),
                        horizontal: context.setWidth(24),
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: context.setHeight(15),
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ProductAndCustomerWidget(
                                  loadingDataController:
                                      loadingDataController,
                                  title: 'customers',
                                  image: AppImages.partner,
                                  syncData: customerRemote == 0
                                      ? "0"
                                      : customerLocal > customerRemote
                                          ? (customerRemote /
                                                  (customerLocal == 0
                                                      ? 1
                                                      : customerLocal) *
                                                  100)
                                              .toStringAsFixed(0)
                                          : ((customerLocal /
                                                      customerRemote) *
                                                  100)
                                              .toStringAsFixed(0),
                                  remoteAndLocalCount:
                                      "$customerRemote / $customerLocal",
                                ),
                                ProductAndCustomerWidget(
                                  loadingDataController:
                                      loadingDataController,
                                  title: "products",
                                  image: AppImages.product,
                                  syncData: productRemote == 0
                                      ? "0"
                                      : productLocal > productRemote
                                          ? (productRemote /
                                                  (productLocal == 0
                                                      ? 1
                                                      : productLocal) *
                                                  100)
                                              .toStringAsFixed(0)
                                          : ((productLocal / productRemote) *
                                                  100)
                                              .toStringAsFixed(0),
                                  remoteAndLocalCount:
                                      "$productRemote / $productLocal",
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.put<DashboardController>(
                                            DashboardController.getInstance())
                                        .toggleProductCustomerInfo();
                                  },
                                  child: Container(
                                      width: context.setWidth(21.15),
                                      height: context.setHeight(21.15),
                                      decoration: ShapeDecoration(
                                        color: Get.find<ThemeController>()
                                                .isDarkMode
                                                .value
                                            ? const Color(0xFF202020)
                                            : const Color(0xFFF1F1F1),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.06,
                                            color: const Color(0x21848484),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              context.setMinSize(6.34)),
                                        ),
                                      ),
                                      child: Center(
                                          child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationX(
                                          Get.put<DashboardController>(
                                                      DashboardController
                                                          .getInstance())
                                                  .isShowProductAndCustomerInfo
                                                  .value
                                              ? 0
                                              : 3.14,
                                        ),
                                        child: SvgPicture.asset(
                                          AppImages.arrowDown,
                                          package: 'shared_widgets',
                                          width: context.setWidth(14.84),
                                          height: context.setHeight(14.84),
                                        ),
                                      ))),
                                )
                              ],
                            ),
                            if (Get.put<DashboardController>(
                                    DashboardController.getInstance())
                                .isShowProductAndCustomerInfo
                                .value) ...[
                              ProductAndCustomerWidget(
                                loadingDataController: loadingDataController,
                                title: 'customers',
                                image: AppImages.partner,
                                syncData: customerRemote == 0
                                    ? "0"
                                    : customerLocal > customerRemote
                                        ? (customerRemote /
                                                (customerLocal == 0
                                                    ? 1
                                                    : customerLocal) *
                                                100)
                                            .toStringAsFixed(0)
                                        : ((customerLocal / customerRemote) *
                                                100)
                                            .toStringAsFixed(0),
                                remoteAndLocalCount:
                                    "$customerRemote / $customerLocal",
                                isShowProductAndCustomerInfo: true,
                              ),
                              ProductAndCustomerWidget(
                                loadingDataController: loadingDataController,
                                title: "products",
                                image: AppImages.product,
                                syncData: productRemote == 0
                                    ? "0"
                                    : productLocal > productRemote
                                        ? (productRemote /
                                                (productLocal == 0
                                                    ? 1
                                                    : productLocal) *
                                                100)
                                            .toStringAsFixed(0)
                                        : ((productLocal / productRemote) *
                                                100)
                                            .toStringAsFixed(0),
                                remoteAndLocalCount:
                                    "$productRemote / $productLocal",
                                isShowProductAndCustomerInfo: true,
                              ),
                            ]
                          ],
                        );
                      }),
                    ),
                  );
                },
              ),
              Text(
                'overview'.tr,
                style: TextStyle(
                  color: Get.find<ThemeController>().isDarkMode.value
                      ? AppColor.white
                      : AppColor.black,
                  fontSize: context.setSp(20.09),
                  fontFamily: 'SansBold',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return SingleChildScrollView(
                            child: Column(
                              spacing: context.setHeight(10),
                              children: [
                                AmountTotalCard(
                                  title: InfoTotalCard.totalSales.text.tr,
                                  total: controller.formatter.format(
                                    controller.finalReportInfo?.totalOutInvoice ??
                                        0.0,
                                  ),
                                  image: AppImages.div2,
                                  color: const Color(0xFF27AE60),
                                ),
                                AmountTotalCard(
                                  title: InfoTotalCard.netIncome.text.tr,
                                  total: controller.formatter.format(
                                    controller.finalReportInfo?.netSales ?? 0.0,
                                  ),
                                  image: AppImages.div1,
                                  color: const Color(0x1916A6B7),
                                ),
                                AmountTotalCard(
                                  title: InfoTotalCard.totalReturns.text.tr,
                                  total: controller.formatter.format(
                                    controller.finalReportInfo?.totalOutRefund ??
                                        0.0,
                                  ),
                                  image: AppImages.div,
                                  color: const Color(0xFFF2AC57),
                                ),
                              ],
                            ),
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.setWidth(10)),
                      child: GetBuilder<FinalReportController>(
                              id: "sales_performance",
                              builder: (controller) {
                                return SalesPerformance(salesTitals: salesTitals, finalReportController: controller);
                              },
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.setWidth(10)),
                      child: GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return BestSellingCategoriesChart(
                            finalReportController: finalReportController,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.setWidth(10)),
                      child: GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return PaymentDataCard(
                            finalReportController: finalReportController,
                          );
                        },
                      ),
                    ),
                    GetBuilder<FinalReportController>(
                      id: "session_card",
                      builder: (controller) {
                        return BestSellingProducts(
                          finalReportController: finalReportController,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentGeometry.center,
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 5,
                  effect: ExpandingDotsEffect(
                    dotHeight:context.setHeight(10) ,
                    dotWidth:context.setWidth(10) ,
                    activeDotColor: AppColor.appColor,
                  ),
                ),
              )
            ],
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

class ProductAndCustomerWidget extends StatelessWidget {
  String title;
  String image;
  String syncData;
  String remoteAndLocalCount;
  bool isShowProductAndCustomerInfo;
  LoadingDataController loadingDataController;
  ProductAndCustomerWidget({
    super.key,
    required this.title,
    required this.image,
    required this.syncData,
    required this.remoteAndLocalCount,
    required this.loadingDataController,
    this.isShowProductAndCustomerInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.setWidth(15),
          children: [
            if (!isShowProductAndCustomerInfo) ...[
              Container(
                width: context.setWidth(40),
                height: context.setHeight(40),
                decoration: ShapeDecoration(
                  color: Get.find<ThemeController>().isDarkMode.value
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
            ] else ...[
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: double.parse(syncData) / 100,
                    strokeWidth: 5,
                    backgroundColor:
                        Get.find<ThemeController>().isDarkMode.value
                            ? const Color(0x26F7F7F7)
                            : const Color(0x268B8B8B),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Get.find<ThemeController>().isDarkMode.value
                            ? const Color(0xFF18BBCD)
                            : const Color(0xFF16A6B7)),
                  ),
                  Text(
                    '$syncData%',
                    style: TextStyle(
                      fontSize: context.setSp(12),
                      fontWeight: FontWeight.bold,
                      color: Get.find<ThemeController>().isDarkMode.value
                          ? AppColor.white
                          : const Color(0xFF6A6A6B),
                    ),
                  ),
                ],
              ),
            ],
            Column(
              spacing: context.setWidth(5),
              children: [
                Text(
                  title.tr,
                  style: TextStyle(
                    color: Get.find<ThemeController>().isDarkMode.value
                        ? AppColor.white
                        : AppColor.black,
                    fontSize: context.setSp(14.80),
                    fontFamily: 'SansMedium',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF16A6B7),
                      fontSize: context.setSp(12.69),
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
              ],
            )
          ],
        ),
        if (isShowProductAndCustomerInfo) ...[
          Row(
            spacing: context.setWidth(10),
            children: [
              SyncButton(
                isHaveBackColor: true,
                title: "Update_All".tr,
                onTap: () async {
                  var result = await loadingDataController.updateAll(
                    name: title == "products"
                        ? Loaddata.products.toString()
                        : Loaddata.customers.toString(),
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
                  onTap: () async {
                    loadingDataController.isUpdate.value = true;
                    var result = await synchronizeBasedOnModelType(
                        type: title == "products"
                            ? Loaddata.products.toString()
                            : Loaddata.customers.toString());
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
        ]
      ],
    );
  }
}

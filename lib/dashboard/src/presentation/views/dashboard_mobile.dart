// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_images.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/domain/dashboard_viewmodel.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/dashboard.dart';
import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_service.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';

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
          child: SingleChildScrollView(
            child: Column(
              spacing: context.setHeight(16),
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
                      height: context.setHeight(90),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductAndCustomerWidget(
                              title: 'customers',
                              syncData: customerRemote == 0
                                  ? "0"
                                  : customerLocal > customerRemote
                                      ? (customerRemote /
                                              (customerLocal == 0
                                                  ? 1
                                                  : customerLocal) *
                                              100)
                                          .toStringAsFixed(0)
                                      : ((customerLocal / customerRemote) * 100)
                                          .toStringAsFixed(0),
                              remoteAndLocalCount:
                                  "$customerRemote / $customerLocal",
                            ),
                            ProductAndCustomerWidget(
                              title: "products",
                              syncData: productRemote == 0
                                  ? "0"
                                  : productLocal > productRemote
                                      ? (productRemote /
                                              (productLocal == 0
                                                  ? 1
                                                  : productLocal) *
                                              100)
                                          .toStringAsFixed(0)
                                      : ((productLocal / productRemote) * 100)
                                          .toStringAsFixed(0),
                              remoteAndLocalCount:
                                  "$productRemote / $productLocal",
                            ),
                            GestureDetector(
                              onTap: () {},
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
                                child: Obx(() {
                                    return Center(
                                        child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationX(
                                        Get.put<DashboardController>(DashboardController.getInstance()).isShowProductAndCustomerInfo.value
                                            ? 0
                                            : 3.14,
                                      ),
                                      child: SvgPicture.asset(
                                        AppImages.arrowDown,
                                        package: 'shared_widgets',
                                        width: context.setWidth(14.84),
                                        height: context.setHeight(14.84),
                                      ),
                                    ));
                                  }
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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

class ProductAndCustomerWidget extends StatelessWidget {
  String title;
  String syncData;
  String remoteAndLocalCount;
  ProductAndCustomerWidget({
    super.key,
    required this.title,
    required this.syncData,
    required this.remoteAndLocalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.setWidth(15),
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: double.parse(syncData) / 100,
              strokeWidth: 5,
              backgroundColor: Get.find<ThemeController>().isDarkMode.value
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
    );
  }
}

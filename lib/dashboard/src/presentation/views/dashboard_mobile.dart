// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/dashboard.dart';
import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
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
            right: context.setWidth(15),
            left: context.setWidth(15),
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
                                return PosCard(sessionController: sessioncontroller);
                              }
                            ),
                          ],
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (sessionController.isLoading.value || loadingDataController.isUpdate.value) {
            return LoadingWidget(message: sessionController.message.value);
          } else {
            return Container(); // Return an empty widget when not loading
          }
        }),
      ],
    );
  }
}
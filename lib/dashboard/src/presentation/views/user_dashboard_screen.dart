// ignore_for_file: unused_field, use_build_context_synchronously, camel_case_types, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:pos_shared_preferences/helper/app_enum.dart';
import 'package:pos_shared_preferences/models/final_report_info.dart';
import 'package:pos_shared_preferences/models/pos_session/posSession.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/progress_bar_with_text.dart';
import 'package:shared_widgets/utils/response_result.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/customer/presentation/views/customers_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/products/presentation/views/product_list_screen.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_list.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/desktop_user_dashboard_screen.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/tablet_user_dashboard_screen.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/widgets/app_basic_data_card.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/widgets/invoices_types_summery_cards.dart';
import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_list.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_service.dart';
import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
import 'package:yousentech_pos_session/pos_session/src/presentation/session_close_screen.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final List<Map> _itemsData = [];
  LoadingDataController loadingDataController =
      Get.put(LoadingDataController());
  late ResponseResult _responseResult;
  late List<ChartData> data;
  final bool _isLoading = true;
  late final SessionController sessionController;
  final FinalReportController finalReportController =
      Get.isRegistered<FinalReportController>()
          ? Get.find<FinalReportController>()
          : Get.put(FinalReportController());
  String? _selectedValue = 'week';

  // int? _selectedValueInd;
  List best_selling_products = [
    ['#12588', 'كود رد  ', '50', "400", "20000"],
    ['#12588', 'كود رد  ', '50', "400", "20000"],
    ['#12588', 'كود رد  ', '50', "400", "20000"],
  ];
  List best_seller = [
    ['1', 'Ahmed Ali', '4,099 ', "25"],
    ['2', 'Ahmed Ali', '4,099 ', "25"],
    ['3', 'Ahmed Ali', '4,099 ', "25"],
  ];

  Future posSessionsData() async {
    await sessionController.posSessionsData();
    await loadingDataController.getitems();
    await sessionController.sessionAmountOpration();
    await finalReportController.getFinalReportInfo();
    return sessionController.posSessionsList;
  }

  @override
  void initState() {
    super.initState();
    data = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    sessionController = Get.put(SessionController());
    posSessionsData();
    SessionService.sessionServiceInstance = null;
    SessionService.getInstance();
  }

  bool isScreenLessThan11Inches() {
    // Get screen width and height in pixels
    double screenWidthInPixels = ScreenUtil().screenWidth;
    double screenHeightInPixels = ScreenUtil().screenHeight;

    // Get the device's pixel density (dpi)
    double pixelDensity = ScreenUtil().pixelRatio! * 160;

    // Convert pixels to inches
    double widthInInches = screenWidthInPixels / pixelDensity;
    double heightInInches = screenHeightInPixels / pixelDensity;

    // Calculate the diagonal screen size in inches
    double screenSizeInInches =
        sqrt(pow(widthInInches, 2) + pow(heightInInches, 2));
    print(screenSizeInInches < 11);
    return screenSizeInInches < 11;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isScreenLessThan11Inches()
            ? TabletUserDashboard()
            : DesktopUserDashboard(),
        Obx(() {
          if (sessionController.isLoading.value ||
              loadingDataController.isUpdate.value) {
            return LoadingWidget(
              message: sessionController.message.value,
            );
          } else {
            return Container(); // Return an empty widget when not loading
          }
        })
      ],
    );
  }
}

stockAlertsItem({required FinalReportController controller}) {
  var length = controller.finalReportInfo == null
      ? 0
      : controller.finalReportInfo!.lessProductsBasedInAvailableQty == null
          ? 0
          : controller.finalReportInfo!.lessProductsBasedInAvailableQty!.length;

  return SingleChildScrollView(
    child: Column(children: [
      Row(children: [
        Expanded(
          child: Text(
            "product_name".tr,
            style: TextStyle(
                fontSize: 7.r,
                color: AppColor.strongDimGray,
                fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'remaining_quantity'.tr,
              style: TextStyle(
                  fontSize: 7.r,
                  color: AppColor.strongDimGray,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ]),
      SizedBox(
        height: 5.r,
      ),
      const Divider(
        height: 0,
      ),
      ...List.generate(length, (index) {
        LessProductsBasedInAvailableQty? item =
            controller.finalReportInfo == null
                ? null
                : controller
                    .finalReportInfo!.lessProductsBasedInAvailableQty![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.r,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item?.getProductNameBasedOnLang ?? "",
                    style: TextStyle(
                        fontSize: 7.r,
                        color: AppColor.strongDimGray,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      '${item?.availableQty ?? ""} ${'packs'.tr}',
                      style: TextStyle(
                          fontSize: 7.r,
                          color: AppColor.strongDimGray,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.r,
            ),
            if (index != length - 1)
              const Divider(
                height: 0,
              )
          ],
        );
      }),
    ]),
  );
}

class paymentHeaderRow extends StatelessWidget {
  paymentHeaderRow({super.key, required this.header, this.isbold = true});
  bool isbold;
  List header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ...header.map(
              (e) => Expanded(
                child: Center(
                  child: Text(
                    e.toString().tr,
                    style: TextStyle(
                        fontSize: 7.r,
                        color: AppColor.strongDimGray,
                        fontWeight:
                            isbold ? FontWeight.w700 : FontWeight.normal),
                  ),
                ),
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}

class SellerHeaderRow extends StatelessWidget {
  SellerHeaderRow({
    super.key,
    required this.data,
  });

  List data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Row(
        children: [
          ...List.generate(
            data.length,
            (index) => index == 0
                ? Expanded(
                    child: Container(
                      height: 20.h,
                      alignment: Alignment.center,
                      color: AppColor.greyWithOpcity,
                      child: Text(
                        '${data[index]}',
                        style: TextStyle(
                          fontSize: 7.r,
                          color: AppColor.strongDimGray,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: 10.h,
                      alignment: Alignment.center,
                      child: Text(
                        '${data[index]}',
                        style: TextStyle(
                          fontSize: 7.r,
                          color: AppColor.charcoalGray,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class paymentDataRow extends StatelessWidget {
  paymentDataRow(
      {super.key,
      required this.data,
      this.isPymentMethod = false,
      this.isSeller = false,
      this.icon = ''});

  List data;
  String icon;
  bool isPymentMethod, isSeller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(
          data.length,
          (index) => index == 0 && isPymentMethod
              ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        icon,
                        clipBehavior: Clip.antiAlias,
                        fit: BoxFit.fill,
                        width: 10.r,
                        height: 10.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      ),
                      Tooltip(
                        message: '${data[index]}',
                        child: Text(
                          '${data[index]}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 7.r,
                            color: AppColor.strongDimGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Tooltip(
                      message:
                          '${data[index]} ${isPymentMethod && index == 1 ? "S.R".tr : ''}',
                      child: Text(
                        '${data[index]} ${isPymentMethod && index == 1 ? "S.R".tr : ''}',
                        style: TextStyle(
                          fontSize: 7.r,
                          overflow: TextOverflow.ellipsis,
                          color: isPymentMethod
                              ? index == 1
                                  ? AppColor.cyanTeal
                                  : AppColor.strongDimGray
                              : AppColor.charcoalGray,
                        ),
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

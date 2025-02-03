// ignore_for_file: unused_field, use_build_context_synchronously, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:pos_desktop/core/config/app_colors.dart';
import 'package:pos_desktop/core/shared_widgets/app_loading.dart';
import 'package:pos_desktop/features/FinalReport/data/final_report_info.dart';
import 'package:pos_desktop/features/FinalReport/domain/final_report_viewmodel.dart';
import 'package:pos_desktop/features/dashboard/presentation/widgets/total_card.dart';
import 'package:pos_desktop/features/session/data/posSession.dart';
import 'package:pos_desktop/features/session/presentation/widgets/pie_test.dart';
import 'package:pos_desktop/features/session/presentation/widgets/refined/invoices_bar_chart.dart';
import 'package:pos_shared_preferences/helper/app_enum.dart';
import 'package:pos_shared_preferences/models/final_report_info.dart';
import 'package:pos_shared_preferences/models/pos_session_model.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/shared_widgets/app_loading.dart';
import 'package:shared_widgets/shared_widgets/progress_bar_with_text.dart';
import 'package:shared_widgets/utils/response_result.dart';
import 'package:yousentech_pos_basic_data_management/yousentech_pos_basic_data_management.dart';
import 'package:yousentech_pos_dashboard/config/app_enums.dart';
import 'package:yousentech_pos_dashboard/config/app_list.dart';
import 'package:yousentech_pos_dashboard/src/presentation/widgets/app_basic_data_card.dart';
import 'package:yousentech_pos_loading_synchronizing_data/config/app_enums.dart';
import 'package:yousentech_pos_loading_synchronizing_data/config/app_list.dart';
import 'package:yousentech_pos_loading_synchronizing_data/yousentech_pos_loading_synchronizing_data.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/config/app_enums.dart';
import '../../../../core/config/app_lists.dart';
import '../../../../core/config/app_shared_pr.dart';
import '../../../../core/shared_widgets/app_basic_data_card.dart';
import '../../../../core/utils/response_result.dart';
import '../../../basic_data_management/customer/presentation/views/customers_list_screen.dart';
import '../../../basic_data_management/products/presentation/product_list_screen.dart';
import '../../../dynamic_color_based_on_bg.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../../session/domain/session_service.dart';
import '../../../session/domain/session_viewmodel.dart';
import '../../../session/presentation/session_close_screen.dart';
import '../../../session/presentation/widgets/line_chart.dart';
import '../../../session/presentation/widgets/refined/invoices_types_summery_cards.dart';
import '../../../session/presentation/widgets/refined/part3.dart';
import '../../../session/presentation/widgets/session_Info.dart';
import '../widgets/filtter_sales_tottal.dart';

class TabletUserDashboard extends StatefulWidget {
  const TabletUserDashboard({super.key});

  @override
  State<TabletUserDashboard> createState() => _TabletUserDashboardState();
}

class _TabletUserDashboardState extends State<TabletUserDashboard> {
  final List<Map> _itemsData = [];
  LoadingDataController loadingDataController =
      Get.put(LoadingDataController());
  late ResponseResult _responseResult;
  late List<_ChartData> data;
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
    // if(sessionController.posSessionsList.isNotEmpty){
    await finalReportController.getFinalReportInfo();
    // }
    return sessionController.posSessionsList;
  }

  @override
  void initState() {
    super.initState();
    data = [
      _ChartData('David', 25),
      _ChartData('Steve', 38),
      _ChartData('Jack', 34),
      _ChartData('Others', 52)
    ];
    sessionController = Get.put(SessionController());
    posSessionsData();
    SessionService.sessionServiceInstance = null;
    SessionService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0.r, right: 32.r, left: 32.r),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  GetBuilder<SessionController>(
                      id: "Sessionbutton",
                      builder: (sessioncontroller) {
                        return Container(
                            width: 0.3.sw,
                            height: 0.2.sh,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            // padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.only(
                                      top: 8.0.r, right: 8.r, left: 8.r),
                                  decoration: BoxDecoration(
                                      color: AppColor.cyanTeal,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        topRight: Radius.circular(10.r),
                                      )),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/image/pos_icon.svg',
                                              clipBehavior: Clip.antiAlias,
                                              fit: BoxFit.fill,
                                              width: 0.01.sw,
                                              height: 0.01.sw,
                                            ),
                                            SizedBox(
                                              height: 0.01.sh,
                                            ),
                                            Text(
                                              SharedPr.currentPosObject!.name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 0.01.sw,
                                                  color: AppColor.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 0.01.sh,
                                            ),
                                            if (sessionController
                                                .posSessionsList
                                                .isNotEmpty) ...[
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${'sessionStartTime'.tr}  ',
                                                      style: TextStyle(
                                                          fontSize: 0.008.sw,
                                                          color:
                                                              AppColor.darkTeal,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                    TextSpan(
                                                      text: sessionController
                                                                  .posSessionsList
                                                                  .last
                                                                  .startTime !=
                                                              ''
                                                          ? intl.DateFormat(
                                                                  'yyyy-MM-dd HH:mm')
                                                              .format(DateTime.parse(
                                                                  sessionController
                                                                          .posSessionsList
                                                                          .last
                                                                          .startTime ??
                                                                      ""))
                                                          : '',
                                                      style: TextStyle(
                                                          fontSize: 0.008.sw,
                                                          color: AppColor.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${'sessionCloseTime'.tr}  ',
                                                      style: TextStyle(
                                                          fontSize: 0.008.sw,
                                                          color:
                                                              AppColor.darkTeal,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                    TextSpan(
                                                      text: sessionController
                                                                  .posSessionsList
                                                                  .last
                                                                  .closeTime !=
                                                              ''
                                                          ? intl.DateFormat(
                                                                  'yyyy-MM-dd HH:mm')
                                                              .format(DateTime.parse(
                                                                  sessionController
                                                                          .posSessionsList
                                                                          .last
                                                                          .closeTime ??
                                                                      ""))
                                                          : '',
                                                      style: TextStyle(
                                                          fontSize: 0.008.sw,
                                                          color: AppColor.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: 10.0.r,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/image/pos_image.svg',
                                              clipBehavior: Clip.antiAlias,
                                              matchTextDirection: true,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ))
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  height: 30.h,
                                  child: Row(
                                    children: [
                                      if ((sessionController
                                                  .posSessionsList.isNotEmpty &&
                                              sessionController
                                                  .checkStartOrResumeSessionAppearance()) ||
                                          sessionController
                                              .posSessionsList.isEmpty)
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              sessionController
                                                  .sessionStartOrResumOnTap(
                                                      context: context);
                                            },
                                            child: Center(
                                              child: Text(
                                                sessionController
                                                        .posSessionsList.isEmpty
                                                    ? "startNewSession".tr
                                                    : sessionController
                                                                .posSessionsList
                                                                .last
                                                                .state ==
                                                            SessionState
                                                                .closedSession
                                                        ? "startNewSession".tr
                                                        : "ResumeSession".tr,
                                                style: TextStyle(
                                                    fontSize: 10.r,
                                                    color: AppColor.deepTeal,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (sessionController
                                              .posSessionsList.isNotEmpty &&
                                          sessionController
                                                  .posSessionsList.last.state !=
                                              SessionState.closedSession) ...[
                                        // if(sessionController.posSessionsList.last.closingAmountSet == 0)
                                        const VerticalDivider(),
                                        Expanded(
                                            child: InkWell(
                                                onTap: () async {
                                                  sessionController
                                                      .isLoading.value = true;
                                                  await sessioncontroller
                                                      .uploadData();

                                                  // await sessionController.countInvoicesByStateAndMoveTypessionRemot(sessionNumber:sessionController.posSessionsList.last.id);
                                                  // await sessionController.countInvoicesByStateAndMoveTypeFromDB(sessionNumber:sessionController.posSessionsList.last.id);
                                                  sessionController
                                                      .isLoading.value = false;
                                                  Get.to(() =>
                                                      SessionCloseScreen2());
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "closeSession".tr,
                                                    style: TextStyle(
                                                        fontSize: 10.r,
                                                        color: AppColor.crimson,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                )))
                                      ]
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }),
                  SizedBox(
                    width: 10.r,
                  ),
                  // product && customer
                  Cardloadingdata(
                    e: loaddata.entries.firstWhere(
                        (element) => element.key == Loaddata.products),
                    menu: SideUserMenu.products,
                    contentpage: const ProductListScreen(),
                  ),
                  SizedBox(
                    width: 10.r,
                  ),
                  Cardloadingdata(
                    e: loaddata.entries.firstWhere(
                        (element) => element.key == Loaddata.customers),
                    menu: SideUserMenu.customers,
                    contentpage: const CustomersListScreen(),
                  ),
                  // filter
                  const Spacer(),
                  GetBuilder<SessionController>(
                      id: "Sessionbutton",
                      builder: (sessioncontroller) {
                        return Builder(builder: (contextBuilder) {
                          return InkWell(
                            onTap: () {
                              showPopover(
                                context: contextBuilder,
                                width: 50.w,
                                direction: PopoverDirection.bottom,
                                backgroundColor: AppColor.white,
                                bodyBuilder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context, setState) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ...dashBoardFilter.map((option) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    option.tr,
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xff6F6F6F),
                                                      fontSize: 2.5.sp,
                                                    ),
                                                  ),
                                                  dense: true,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          vertical: -4.0),
                                                  tileColor: _selectedValue ==
                                                          option
                                                      ? AppColor
                                                          .greyWithOpcity // Highlight the selected tile
                                                      : Colors.transparent,
                                                  onTap: () async {
                                                    setState(() {
                                                      _selectedValue = option;
                                                    });
                                                    await finalReportController
                                                        .getFinalReportInfo(
                                                            dateFilterKey:
                                                                _selectedValue!);
                                                    sessioncontroller.update(
                                                        ['Sessionbutton']);
                                                    Navigator.of(contextBuilder)
                                                        .pop();
                                                  },
                                                ),
                                                Divider(
                                                  height: 0,
                                                  color: AppColor.gray
                                                      .withOpacity(0.3),
                                                )
                                              ],
                                            );
                                          })
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.lavenderGray2,
                                  size: 10.r,
                                ),
                                SizedBox(
                                  width: 5.r,
                                ),
                                Text(
                                  _selectedValue!.tr,
                                  style:
                                      TextStyle(color: AppColor.lavenderGray2),
                                ),
                                SizedBox(
                                  width: 5.r,
                                ),
                                Icon(
                                  FontAwesomeIcons.sliders,
                                  color: Colors.grey,
                                  size: 3.sp,
                                ),
                                // SvgPicture.asset(
                                //   'assets/image/filter.svg',
                                // ),
                              ],
                            ),
                          );
                        });
                      })
                ]),
                SizedBox(
                  height: 10.r,
                ),
                // cardes
                // GetBuilder<SessionController>(
                //     id: "session_amount_opration_card",
                //     builder:
                GetBuilder<FinalReportController>(
                    id: "session_card",
                    builder: (controller) {
                      return Row(
                        children: [
                          CustomCard(
                            title: InfoTotalCard.totalSales.text,

                            total: controller.formatter.format(
                                controller.finalReportInfo?.totalOutInvoice ??
                                    0.0),
                            color: InfoTotalCard.totalSales.color,
                            icon: InfoTotalCard.totalSales.icon,
                            isMiddle: false,
                            height: 0.09.sh, isdashbord: true,

                            // showDeletIcon: index == 0 &&
                            //         sessionController.pendingInvoiceNo != 0
                            //     ? true
                            //     : false,
                          ),
                          CustomCard(
                            title: InfoTotalCard.netIncome.text,

                            total: controller.formatter.format(
                                controller.finalReportInfo?.netSales ?? 0.0),
                            color: InfoTotalCard.netIncome.color,
                            icon: InfoTotalCard.netIncome.icon,
                            isMiddle: true,
                            height: 0.09.sh, isdashbord: true,

                            // showDeletIcon: index == 0 &&
                            //         sessionController.pendingInvoiceNo != 0
                            //     ? true
                            //     : false,
                          ),

                          CustomCard(
                            title: InfoTotalCard.totalReturns.text,

                            total: controller.formatter.format(
                                controller.finalReportInfo?.totalOutRefund ??
                                    0.0),
                            color: InfoTotalCard.totalReturns.color,
                            icon: InfoTotalCard.totalReturns.icon,
                            isdashbord: true,
                            isMiddle: false,
                            height: 0.09.sh,
                            // showDeletIcon: index == 0 &&
                            //         sessionController.pendingInvoiceNo != 0
                            //     ? true
                            //     : false,
                            showSendIcon: false,
                          ),
// infoCard(text: controller.formatter.format(
//                                 controller.finalReportInfo?.totalOutInvoice ??
//                                     0.0), titel:InfoTotalCard.totalSales.,)
                          // TotalCard(
                          //   info: InfoTotalCard.totalSales,
                          //   // totalPrice: sessionController
                          //   //         .sessionAmountOprationCard.isEmpty
                          //   //     ? "0.0"
                          //   //     : sessionController.formatter.format(
                          //   //         sessionController
                          //   //                         .sessionAmountOprationCard[
                          //   //                     "session_amount_opration"]
                          //   //                 ["total_out_invoice"] ??
                          //   //             0.0)
                          //   totalPrice: controller.formatter.format(
                          //       controller.finalReportInfo?.totalOutInvoice ??
                          //           0.0),
                          // ),
                          // TotalCard(
                          //   info: InfoTotalCard.netIncome,
                          //   isMiddle: true,
                          //   // totalPrice: sessionController
                          //   //         .sessionAmountOprationCard.isEmpty
                          //   //     ? "0.0"
                          //   //     : sessionController.formatter.format(
                          //   //         (sessionController.sessionAmountOprationCard[
                          //   //                         "session_amount_opration"]
                          //   //                     ["total_out_invoice"] ??
                          //   //                 0.0) -
                          //   //             (sessionController
                          //   //                             .sessionAmountOprationCard[
                          //   //                         "session_amount_opration"]
                          //   //                     ["total_out_refund"] ??
                          //   //                 0.0)
                          //   // ),
                          //   totalPrice: controller.formatter.format(
                          //       controller.finalReportInfo?.netSales ?? 0.0),
                          // ),
                          // TotalCard(
                          //   info: InfoTotalCard.totalReturns,
                          //   // totalPrice: sessionController
                          //   //         .sessionAmountOprationCard.isEmpty
                          //   //     ? "0.0"
                          //   //     : sessionController.formatter.format(
                          //   //         sessionController.sessionAmountOprationCard[
                          //   //                     "session_amount_opration"]
                          //   //                 ["total_out_refund"] ??
                          //   //             0.0),
                          //   totalPrice: controller.formatter.format(
                          //       controller.finalReportInfo?.totalOutRefund ??
                          //           0.0),
                          // ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 10.r,
                ),
                //step 3
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return Expanded(
                            child: Container(
                                height: 0.2.sh,
                                padding: EdgeInsets.all(10.r),
                                // margin:
                                //     EdgeInsets.symmetric(vertical: 10.r),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'best_selling_products'.tr,
                                      style: TextStyle(
                                          fontSize: 10.r,
                                          color: AppColor.strongDimGray,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10.r,
                                    ),
                                    paymentHeaderRow(header: const [
                                      'ID',
                                      'product_name',
                                      'quantity',
                                      "price",
                                      "total"
                                    ]),
                                    Expanded(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              BasedSellingProduct? item =
                                                  controller.finalReportInfo ==
                                                          null
                                                      ? null
                                                      : controller
                                                              .finalReportInfo!
                                                              .basedSellingProduct![
                                                          index];
                                              List products = item != null
                                                  ? [
                                                      item.productId,
                                                      item.getProductNameBasedOnLang,
                                                      item.totalQty,
                                                      item.unitPrice,
                                                      item.totalPrice
                                                    ]
                                                  : [];
                                              if (products.isNotEmpty) {
                                                products[3] =
                                                    finalReportController
                                                        .formatter
                                                        .format(
                                                            item!.unitPrice);
                                                products[4] =
                                                    finalReportController
                                                        .formatter
                                                        .format(
                                                            item.totalPrice);
                                              }
                                              return paymentDataRow(
                                                data: products,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                            itemCount: controller
                                                        .finalReportInfo ==
                                                    null
                                                ? 0
                                                : controller.finalReportInfo!
                                                            .basedSellingProduct ==
                                                        null
                                                    ? 0
                                                    : controller
                                                        .finalReportInfo!
                                                        .basedSellingProduct!
                                                        .length
                                            // best_selling_products.length

                                            ))
                                  ],
                                )),
                          );
                        }),
                    SizedBox(
                      width: 10.r,
                    ),
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          var data = controller
                              .finalReportInfo?.productBasedCategories
                              ?.map((e) => e.totalQty!)
                              .toList();
                          var indector = controller
                              .finalReportInfo?.productBasedCategories
                              ?.map((e) => e.getProductNameBasedOnLang)
                              .toList();
                          double sum = data == null || data.isEmpty
                              ? 0.0
                              : data.reduce((a, b) => a + b);
                          double opsity = 1;

                          return Expanded(
                              child: Container(
                                  height: 0.2.sh,
                                  padding: EdgeInsets.all(10.r),
                                  // margin: EdgeInsets.symmetric(
                                  //     vertical: 10.r),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'best_product_by_cat'.tr,
                                          style: TextStyle(
                                              fontSize: 10.r,
                                              color: AppColor.strongDimGray,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 10.r,
                                        ),
                                        if (data != null)
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ...List.generate(data.length,
                                                      (index) {
                                                    opsity -= (opsity /
                                                        (data.length + 1));

                                                    // print(data[index]);
                                                    return Column(
                                                      children: [
                                                        ProgressBarWithText(
                                                          text:
                                                              '(${indector![index]}) ${controller.formatter.format((data[index] / sum) * 100)} %',
                                                          percentage: double
                                                              .parse(controller
                                                                  .formatter
                                                                  .format(data[
                                                                          index] /
                                                                      sum)),
                                                          backgroundColor:
                                                              AppColor.cyanTeal,
                                                          progressColor:
                                                              AppColor.cyanTeal
                                                                  .withOpacity(
                                                                      opsity),
                                                        ),
                                                        // LineIndecetorContainer(
                                                        //   value:
                                                        //       '(${indector![index]}) ${controller.formatter.format((data[index] / sum) * 100)} %',
                                                        //   prec: double.parse(
                                                        //       controller.formatter
                                                        //           .format(data[
                                                        //                   index] /
                                                        //               sum)),
                                                        //   color: AppColor.cyanTeal
                                                        //       .withOpacity(
                                                        //           opsity),
                                                        // ),
                                                        SizedBox(
                                                          height: 1.r,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        // SizedBox(
                                        //   height: 1.r,
                                        // ),
                                        // LineIndecetorContainer(
                                        //   value: '${'فواكهه'} ${20} %',
                                        //   prec: 20 / 100,
                                        //   color: AppColor.amberDark,
                                        // ),
                                        // SizedBox(
                                        //   height: 1.r,
                                        // ),
                                        // LineIndecetorContainer(
                                        //   value: '${'فواكهه'} ${10} %',
                                        //   prec: 10 / 100,
                                        //   color: AppColor.amberLight,
                                        // ),
                                        // SizedBox(
                                        //   height: 1.r,
                                        // ),
                                        // LineIndecetorContainer(
                                        //   value: '${'فواكهه'} ${20} %',
                                        //   prec: 20 / 100,
                                        //   color: AppColor.aqua,
                                        // )
                                      ])));
                        }),
                    SizedBox(
                      width: 10.r,
                    ),
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return Expanded(
                              child: Container(
                                  height: 0.2.sh,
                                  padding: EdgeInsets.all(10.r),
                                  // margin: EdgeInsets.symmetric(
                                  //     vertical: 10.r),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'stock_alerts'.tr,
                                          style: TextStyle(
                                              fontSize: 10.r,
                                              color: AppColor.strongDimGray,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "(${"products_about_to_run_out".tr})",
                                          style: TextStyle(
                                            fontSize: 8.r,
                                            color: AppColor.lavenderGray,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.r,
                                        ),
                                        Expanded(
                                            child: stockAlertsItem(
                                                controller: controller)),
                                      ])));
                        })
                    //Top_sales_sessions
                    // GetBuilder<FinalReportController>(
                    //     id: "session_card",
                    //     builder: (controller) {
                    //       return Expanded(
                    //         child: Container(
                    //             height: 0.2.sh,
                    //             padding: EdgeInsets.all(10.r),
                    //             margin:
                    //                 EdgeInsets.symmetric(vertical: 10.r),
                    //             decoration: BoxDecoration(
                    //                 color: AppColor.white,
                    //                 borderRadius:
                    //                     BorderRadius.circular(10.r)),
                    //             child: Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'Top_sales_sessions'.tr,
                    //                   style: TextStyle(
                    //                       fontSize: 10.r,
                    //                       color: AppColor.strongDimGray,
                    //                       fontWeight: FontWeight.w700),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10.r,
                    //                 ),
                    //                 paymentHeaderRow(header: const [
                    //                   'session_number',
                    //                   'start_date',
                    //                   'balance_opening',
                    //                   'closingAmount',
                    //                   "salesAmount"
                    //                 ]),
                    //                 Expanded(
                    //                     child: ListView.separated(
                    //                         shrinkWrap: true,
                    //                         itemBuilder:
                    //                             (BuildContext context,
                    //                                 int index) {
                    //                           PosSession? item = controller
                    //                                       .finalReportInfo ==
                    //                                   null
                    //                               ? null
                    //                               : controller
                    //                                   .finalReportInfo!
                    //                                   .topSession![index];
                    //                           List session = item != null
                    //                               ? [
                    //                                   item.id,
                    //                                   item.startTime,
                    //                                   item.balanceOpening,
                    //                                   item.closingAmount,
                    //                                   item.totalSales,
                    //                                 ]
                    //                               : [];
                    //                           if (session.isNotEmpty) {
                    //                             session[1] = DateFormat(
                    //                                     'yyyy-MM-dd')
                    //                                 .format(DateTime
                    //                                     .parse(item!
                    //                                         .startTime!));
                    //                             session[2] =
                    //                                 finalReportController
                    //                                     .formatter
                    //                                     .format(item
                    //                                         .balanceOpening);

                    //                             session[3] =
                    //                                 finalReportController
                    //                                     .formatter
                    //                                     .format(item
                    //                                         .closingAmount);
                    //                             session[4] =
                    //                                 finalReportController
                    //                                     .formatter
                    //                                     .format(item
                    //                                         .totalSales);
                    //                           }
                    //                           return paymentDataRow(
                    //                             data: session,
                    //                           );
                    //                         },
                    //                         separatorBuilder:
                    //                             (context, index) {
                    //                           return const Divider();
                    //                         },
                    //                         itemCount: controller
                    //                                     .finalReportInfo ==
                    //                                 null
                    //                             ? 0
                    //                             : controller
                    //                                 .finalReportInfo!
                    //                                 .topSession!
                    //                                 .length))
                    //               ],
                    //             )),
                    //       );
                    //     }),

                    // SizedBox(
                    //   width: 10.r,
                    // ),
                    //lessProductsBasedInAvailableQty
                    // GetBuilder<FinalReportController>(
                    //     id: "session_card",
                    //     builder: (controller) {
                    //       return Expanded(
                    //         child: Container(
                    //             height: 0.2.sh,
                    //             padding: EdgeInsets.all(10.r),
                    //             margin:
                    //                 EdgeInsets.symmetric(vertical: 10.r),
                    //             decoration: BoxDecoration(
                    //                 color: AppColor.white,
                    //                 borderRadius:
                    //                     BorderRadius.circular(10.r)),
                    //             child: Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'less_Products_based_on_availableQty'
                    //                       .tr,
                    //                   style: TextStyle(
                    //                       fontSize: 10.r,
                    //                       color: AppColor.strongDimGray,
                    //                       fontWeight: FontWeight.w700),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10.r,
                    //                 ),
                    //                 paymentHeaderRow(header: const [
                    //                   'ID',
                    //                   'product_name',
                    //                   'quantity_available',
                    //                 ]),
                    //                 Expanded(
                    //                     child: ListView.separated(
                    //                         shrinkWrap: true,
                    //                         itemBuilder:
                    //                             (BuildContext context,
                    //                                 int index) {
                    //                           LessProductsBasedInAvailableQty?
                    //                               item =
                    //                               controller.finalReportInfo ==
                    //                                       null
                    //                                   ? null
                    //                                   : controller
                    //                                       .finalReportInfo!
                    //                                       .lessProductsBasedInAvailableQty![index];
                    //                           List product = item != null
                    //                               ? [
                    //                                   item.productId,
                    //                                   item.getProductNameBasedOnLang,
                    //                                   item.availableQty,
                    //                                 ]
                    //                               : [];

                    //                           return paymentDataRow(
                    //                             data: product,
                    //                           );
                    //                         },
                    //                         separatorBuilder:
                    //                             (context, index) {
                    //                           return const Divider();
                    //                         },
                    //                         itemCount: controller
                    //                                     .finalReportInfo ==
                    //                                 null
                    //                             ? 0
                    //                             : controller
                    //                                 .finalReportInfo!
                    //                                 .lessProductsBasedInAvailableQty!
                    //                                 .length))
                    //               ],
                    //             )),
                    //       );
                    //     }),

                    // ,
                    // InvoicesBarChart(
                    //   sessionController: sessionController,
                    //   isEmpty: true,
                    // ),
                    // ,
                    // Expanded(
                    //   child: Container(
                    //       height: 0.25.sh,
                    //       decoration: BoxDecoration(
                    //           color: AppColor.white,
                    //           borderRadius: BorderRadius.circular(10.r)),
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 20.0.r, vertical: 5.r),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   flex: 3,
                    //                   child: Text(
                    //                     InfoTotalCard.totalSales.text.tr,
                    //                     style: TextStyle(
                    //                         fontSize: 12.r,
                    //                         color: AppColor.strongDimGray,
                    //                         fontWeight: FontWeight.w700),
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   flex: 2,
                    //                   child: GetBuilder<SessionController>(
                    //                       builder: (context) {
                    //                     return Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceEvenly,
                    //                       children: [
                    //                         FiltterSalesTottal(
                    //                           id: period[0]['id'],
                    //                           text: period[0]['name'],
                    //                         ),
                    //                         FiltterSalesTottal(
                    //                           id: period[1]['id'],
                    //                           text: period[1]['name'],
                    //                         ),
                    //                         FiltterSalesTottal(
                    //                           id: period[2]['id'],
                    //                           text: period[2]['name'],
                    //                         ),
                    //                         FiltterSalesTottal(
                    //                           id: period[3]['id'],
                    //                           text: period[3]['name'],
                    //                         ),
                    //                       ],
                    //                     );
                    //                   }),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           Expanded(child: LineChartSample2())
                    //         ],
                    //       )),
                    // ),
                    // GetBuilder<FinalReportController>(
                    //   id: "session_card",
                    //   builder: (controller) {
                    //     var data = controller
                    //         .finalReportInfo?.productBasedCategories
                    //         ?.map((e) => e.totalQty!)
                    //         .toList();
                    //     var indector = controller
                    //         .finalReportInfo?.productBasedCategories
                    //         ?.map((e) => e.getProductNameBasedOnLang)
                    //         .toList();
                    //     return Expanded(
                    //       flex: 1,
                    //       child: Container(
                    //           height: 0.25.sh,
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: 20.0.r, vertical: 10.r),
                    //           decoration: BoxDecoration(
                    //               color: AppColor.white,
                    //               borderRadius: BorderRadius.circular(10.r)),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 'best_products_by_cat'.tr,
                    //                 style: TextStyle(
                    //                     fontSize: 10.r,
                    //                     color: AppColor.strongDimGray,
                    //                     fontWeight: FontWeight.w700),
                    //               ),
                    // Expanded(
                    //                   child: PieChartSample(
                    //                 data: data ?? [],
                    //                 indector: indector ?? [],
                    //               )),
                    //             ],
                    //           )),
                    //     );
                    //   })
                  ],
                ),
                SizedBox(
                  height: 10.r,
                ),
                Row(
                  children: [
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          String theTopSession = controller.finalReportInfo ==
                                      null ||
                                  controller.finalReportInfo!.topSession == null
                              ? '0'
                              : controller.finalReportInfo!.topSession!.isEmpty
                                  ? '0'
                                  : controller.formatter.format(controller
                                      .finalReportInfo!
                                      .topSession!
                                      .first
                                      .totalSales!);
                          return Expanded(
                            flex: 2,
                            child: Container(
                                height: 0.2.sh,
                                padding: EdgeInsets.all(10.r),
                                // margin: EdgeInsets.symmetric(vertical: 10.r),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        onTap: (index) {
                                          if (index == 0) {
                                            controller.isbestsellertab.value =
                                                false;
                                          } else {
                                            controller.isbestsellertab.value =
                                                true;
                                          }
                                          controller.update(["session_card"]);
                                        },
                                        indicatorColor: AppColor.cyanTeal,
                                        tabs: [
                                          Column(
                                            children: [
                                              Text(
                                                'Top_sales_sessions'.tr,
                                                style: TextStyle(
                                                    fontSize: 10.r,
                                                    color:
                                                        AppColor.strongDimGray,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                      text: theTopSession,
                                                      style: TextStyle(
                                                        fontSize: 8.r,
                                                        color: controller
                                                                .isbestsellertab
                                                                .value
                                                            ? AppColor
                                                                .strongDimGray
                                                            : AppColor.cyanTeal,
                                                        fontFamily: 'Tajawal',
                                                      ),
                                                    ),
                                                    // get the number
                                                    TextSpan(
                                                      text: ' ${'S.R'.tr}',
                                                      style: TextStyle(
                                                        fontSize: 8.r,
                                                        color: AppColor
                                                            .strongDimGray,
                                                        fontFamily: 'Tajawal',
                                                      ),
                                                    ),
                                                  ])),
                                              // Text(
                                              //   " ${'S.R'.tr}",
                                              //   style: TextStyle(
                                              //       color: controller
                                              //               .isbestsellertab
                                              //               .value
                                              //           ? AppColor.darkGray8
                                              //           : AppColor.cyanTeal,
                                              //       fontWeight:
                                              //           FontWeight.w700),
                                              // ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'best_sellers'.tr,
                                                style: TextStyle(
                                                  fontSize: 10.r,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.strongDimGray,
                                                ),
                                              ),
                                              Text(
                                                best_seller.first![1]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 8.r,
                                                  color: controller
                                                          .isbestsellertab.value
                                                      ? AppColor.cyanTeal
                                                      : AppColor.strongDimGray,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            // Use PageStorageKey to preserve state

                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.r),
                                                  child: paymentHeaderRow(
                                                    header: const [
                                                      'session_number',
                                                      'start_date',
                                                      'balance_opening',
                                                      'closingAmount',
                                                      "salesAmount"
                                                    ],
                                                    isbold: false,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          PosSession? item = controller
                                                                      .finalReportInfo ==
                                                                  null
                                                              ? null
                                                              : controller
                                                                  .finalReportInfo!
                                                                  .topSession![index];
                                                          List session =
                                                              item != null
                                                                  ? [
                                                                      item.id,
                                                                      item.startTime,
                                                                      item.balanceOpening,
                                                                      item.closingAmount,
                                                                      item.totalSales,
                                                                    ]
                                                                  : [];
                                                          if (session
                                                              .isNotEmpty) {
                                                            session[
                                                                1] = DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(DateTime
                                                                    .parse(item!
                                                                        .startTime!));
                                                            session[2] =
                                                                finalReportController
                                                                    .formatter
                                                                    .format(item
                                                                        .balanceOpening);

                                                            session[3] =
                                                                finalReportController
                                                                    .formatter
                                                                    .format(item
                                                                        .closingAmount);
                                                            session[4] =
                                                                finalReportController
                                                                    .formatter
                                                                    .format(item
                                                                        .totalSales);
                                                          }
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        1.r),
                                                            child:
                                                                paymentDataRow(
                                                              data: session,
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return const Divider(
                                                              // height: 50.r,
                                                              );
                                                        },
                                                        itemCount: controller
                                                                    .finalReportInfo ==
                                                                null
                                                            ? 0
                                                            : controller.finalReportInfo!
                                                                        .topSession ==
                                                                    null
                                                                ? 0
                                                                : controller
                                                                    .finalReportInfo!
                                                                    .topSession!
                                                                    .length))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.r),
                                                  child: paymentHeaderRow(
                                                    header: const [
                                                      'NO',
                                                      'name',
                                                      'total_sales',
                                                      'no_sessions',
                                                    ],
                                                    isbold: false,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        1.r),
                                                            child:
                                                                paymentDataRow(
                                                              data: best_seller[
                                                                      index]
                                                                  as List,
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Divider(
                                                              // height: 5.r,
                                                              );
                                                        },
                                                        itemCount: best_seller
                                                            .length)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [

                                //     Text(
                                //       'best_selling_products'.tr,
                                //       style: TextStyle(
                                //           fontSize: 10.r,
                                //           color: AppColor.strongDimGray,
                                //           fontWeight: FontWeight.w700),
                                //     ),
                                //     SizedBox(
                                //       height: 10.r,
                                //     ),
                                //     paymentHeaderRow(header: const [
                                //       'ID',
                                //       'product_name',
                                //       'quantity',
                                //       "price",
                                //       "total"
                                //     ]),
                                //     Expanded(
                                //         child: ListView.separated(
                                //             shrinkWrap: true,
                                //             itemBuilder: (BuildContext context,
                                //                 int index) {
                                //               BasedSellingProduct? item =
                                //                   controller.finalReportInfo ==
                                //                           null
                                //                       ? null
                                //                       : controller
                                //                               .finalReportInfo!
                                //                               .basedSellingProduct![
                                //                           index];
                                //               List products = item != null
                                //                   ? [
                                //                       item.productId,
                                //                       item.getProductNameBasedOnLang,
                                //                       item.totalQty,
                                //                       item.unitPrice,
                                //                       item.totalPrice
                                //                     ]
                                //                   : [];
                                //               if (products.isNotEmpty) {
                                //                 products[3] =
                                //                     finalReportController
                                //                         .formatter
                                //                         .format(
                                //                             item!.unitPrice);
                                //                 products[4] =
                                //                     finalReportController
                                //                         .formatter
                                //                         .format(
                                //                             item.totalPrice);
                                //               }
                                //               return paymentDataRow(
                                //                 data: products,
                                //               );
                                //             },
                                //             separatorBuilder: (context, index) {
                                //               return const Divider();
                                //             },
                                //             itemCount:
                                //                 controller.finalReportInfo ==
                                //                         null
                                //                     ? 0
                                //                     : controller
                                //                         .finalReportInfo!
                                //                         .basedSellingProduct!
                                //                         .length
                                //             // best_selling_products.length

                                //             ))
                                //   ],
                                // )
                                ),
                          );
                        }),
                    SizedBox(
                      width: 10.r,
                    ),
                    // payment Method
                    GetBuilder<FinalReportController>(
                        id: "session_card",
                        builder: (controller) {
                          return Expanded(
                            flex: 1,
                            child: Container(
                                height: 0.2.sh,
                                padding: EdgeInsets.all(10.r),
                                // margin: EdgeInsets.symmetric(vertical: 10.r),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'payment_methods'.tr,
                                      style: TextStyle(
                                          fontSize: 10.r,
                                          color: AppColor.strongDimGray,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10.r,
                                    ),
                                    paymentHeaderRow(header: const [
                                      'paymentType',
                                      'total',
                                      'num_times'
                                    ]),
                                    Expanded(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String name =
                                                  SharedPr.lang == "ar"
                                                      ? finalReportController
                                                          .invoicePaymentMethod[
                                                              index]
                                                          .accountJournalName
                                                          .ar001
                                                      : finalReportController
                                                          .invoicePaymentMethod[
                                                              index]
                                                          .accountJournalName
                                                          .enUS;
                                              String amount = finalReportController
                                                  .formatter
                                                  .format(finalReportController
                                                      .invoicePaymentMethod[
                                                          index]
                                                      .totalAmount);
                                              String invoiceCount =
                                                  finalReportController
                                                      .invoicePaymentMethod[
                                                          index]
                                                      .invoiceCount
                                                      .toString();
                                              List item = [
                                                name,
                                                amount,
                                                invoiceCount
                                              ];
                                              return paymentDataRow(
                                                data: item,
                                                icon: finalReportController
                                                            .invoicePaymentMethod[
                                                                index]
                                                            .type ==
                                                        PaymentType.cash.name
                                                    ? 'assets/image/cash.svg'
                                                    : finalReportController
                                                                .invoicePaymentMethod[
                                                                    index]
                                                                .type ==
                                                            PaymentType
                                                                .bank.name
                                                        ? 'assets/image/credit_card.svg'
                                                        : 'assets/image/wallet.svg',
                                                isPymentMethod: true,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                            itemCount: controller
                                                .invoicePaymentMethod.length))
                                  ],
                                )),
                          );
                        }),

                    // SizedBox(
                    //   width: 0.01.sw,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //       height: 0.2.sh,
                    //       padding: EdgeInsets.all(10.r),
                    //       margin: EdgeInsets.symmetric(vertical: 10.r),
                    //       decoration: BoxDecoration(
                    //           color: AppColor.white,
                    //           borderRadius: BorderRadius.circular(10.r)),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'best_sellers'.tr,
                    //             style: TextStyle(
                    //                 fontSize: 10.r,
                    //                 color: AppColor.strongDimGray,
                    //                 fontWeight: FontWeight.w700),
                    //           ),
                    //           SizedBox(
                    //             height: 10.r,
                    //           ),
                    //           paymentHeaderRow(header: const [
                    //             'NO',
                    //             'name',
                    //             'total_sales',
                    //             'no_sessions',
                    //           ]),
                    //           Expanded(
                    //               child: ListView.separated(
                    //                   shrinkWrap: true,
                    //                   itemBuilder:
                    //                       (BuildContext context, int index) {
                    //                     return paymentDataRow(
                    //                       data: best_seller[index] as List,
                    //                     );
                    //                   },
                    //                   separatorBuilder: (context, index) {
                    //                     return const Divider();
                    //                   },
                    //                   itemCount: best_seller.length)),
                    //           // ...[
                    //           //   ['1', 'Ahmed Ali', '4,099 ', "25"],
                    //           //   ['2', 'Ahmed Ali', '4,099 ', "25"],
                    //           //   ['3', 'Ahmed Ali', '4,099 ', "25"],
                    //           // ].map(
                    //           //   (e) => SellerHeaderRow(header: e),
                    //           // )
                    //         ],
                    //       )),
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
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

        // var item = list[index];
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
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     padding: EdgeInsets.all(3.r),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: AppColor.palePink,
                //     ),
                //     child: Text(
                //       'Reorder'.tr,
                //       style: TextStyle(
                //           fontSize: 7.r,
                //           color: AppColor.crimsonRed,
                //           fontWeight: FontWeight.w700),
                //     ),
                //   ),
                // ),
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
  // return ListView.builder(
  //   itemCount: list.length,
  //   itemBuilder: (BuildContext, index) {
  //     var item = list[index];
  //     return Container(
  //       height: 0.05.sh,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             item['name'].toString().tr,
  //             style: TextStyle(
  //                 fontSize: 8.r,
  //                 color: AppColor.strongDimGray,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 '${'remaining_quantity'.tr} ${item['naquantitye']} ${'packs'.tr}',
  //                 style: TextStyle(
  //                     fontSize: 8.r,
  //                     color: AppColor.strongDimGray,
  //                     fontWeight: FontWeight.w700),
  //               ),
  //               InkWell(
  //                 child: Container(
  //                   padding: EdgeInsets.all(3.r),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10.r),
  //                     color: AppColor.palePink,
  //                   ),
  //                   child: Text(
  //                     'Reorder'.tr,
  //                     style: TextStyle(
  //                         fontSize: 8.r,
  //                         color: AppColor.crimsonRed,
  //                         fontWeight: FontWeight.w700),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           if (index != list.length - 1) const Divider()
  //         ],
  //       ),
  //     );
  //   },
  // );
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
// class SellerHeaderRow extends StatelessWidget {
//   SellerHeaderRow({super.key, required this.header});
//   List header;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 0.05.sh,
//       child: Row(
//         children: [
//           ...List.generate(
//             header.length,
//             (index) => index == 0
//                 ? Expanded(
//                     child: Container(
//                       height: 0.05.sh,
//                       alignment: Alignment.center,
//                       color: AppColor.greyWithOpcity,
//                       child: Text(
//                         '${header[index]}',
//                         style: TextStyle(
//                             fontSize: 3.sp,
//                             color: AppColor.strongDimGray,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   )
//                 : Expanded(
//                     child: Container(
//                       height: 0.05.sh,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '${header[index]}',
//                             style: TextStyle(
//                                 fontSize: 3.sp,
//                                 color: AppColor.strongDimGray,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                           Divider(
//                             color: AppColor.lightPeriwinkle,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//           )
//         ],
//       ),
//     );
//   }
// }

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

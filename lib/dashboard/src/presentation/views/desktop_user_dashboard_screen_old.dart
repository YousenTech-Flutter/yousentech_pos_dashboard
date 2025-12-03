// // ignore_for_file: unused_field, use_build_context_synchronously, camel_case_types, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:intl/intl.dart';
// import 'package:popover/popover.dart';
// import 'package:pos_shared_preferences/helper/app_enum.dart';
// import 'package:pos_shared_preferences/models/final_report_info.dart';
// import 'package:pos_shared_preferences/models/pos_session/posSession.dart';
// import 'package:pos_shared_preferences/pos_shared_preferences.dart';
// import 'package:shared_widgets/config/app_colors.dart';
// import 'package:shared_widgets/config/app_styles.dart';
// import 'package:shared_widgets/shared_widgets/app_loading.dart';
// import 'package:shared_widgets/shared_widgets/progress_bar_with_text.dart';
// import 'package:shared_widgets/utils/response_result.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/customer/presentation/views/customers_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/products/presentation/product_list_screen.dart';
// import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';
// import 'package:yousentech_pos_dashboard/dashboard/config/app_list.dart';
// import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/user_dashboard_screen.dart';
// import 'package:yousentech_pos_dashboard/dashboard/src/presentation/widgets/app_basic_data_card.dart';
// import 'package:yousentech_pos_dashboard/dashboard/src/presentation/widgets/invoices_types_summery_cards.dart';
// import 'package:yousentech_pos_final_report/final_report/src/domain/final_report_viewmodel.dart';
// import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_enums.dart';
// import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/config/app_list.dart';
// import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
// import 'package:yousentech_pos_payment/payment/config/app_enums.dart';
// import 'package:yousentech_pos_session/pos_session/src/domain/session_service.dart';
// import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
// import 'package:yousentech_pos_session/pos_session/src/presentation/session_close_screen.dart';

// class DesktopUserDashboard extends StatefulWidget {
//   const DesktopUserDashboard({super.key});

//   @override
//   State<DesktopUserDashboard> createState() => _DesktopUserDashboardState();
// }

// class _DesktopUserDashboardState extends State<DesktopUserDashboard> {
//   final List<Map> _itemsData = [];
//   LoadingDataController loadingDataController =
//       Get.put(LoadingDataController());
//   late ResponseResult _responseResult;
//   late List<ChartData> data;
//   final bool _isLoading = true;
//   late final SessionController sessionController;
//   final FinalReportController finalReportController =
//       Get.isRegistered<FinalReportController>()
//           ? Get.find<FinalReportController>()
//           : Get.put(FinalReportController());
//   String? _selectedValue = 'week';

//   // int? _selectedValueInd;
//   List best_selling_products = [
//     ['#12588', 'كود رد  ', '50', "400", "20000"],
//     ['#12588', 'كود رد  ', '50', "400", "20000"],
//     ['#12588', 'كود رد  ', '50', "400", "20000"],
//   ];
//   List best_seller = [
//     ['1', 'Ahmed Ali', '4,099 ', "25"],
//     ['2', 'Ahmed Ali', '4,099 ', "25"],
//     ['3', 'Ahmed Ali', '4,099 ', "25"],
//   ];

//   Future posSessionsData() async {
//     await sessionController.posSessionsData();
//     await loadingDataController.getitems();
//     await sessionController.sessionAmountOpration();
//     await finalReportController.getFinalReportInfo();
//     return sessionController.posSessionsList;
//   }

//   @override
//   void initState() {
//     super.initState();
//     data = [
//       ChartData('David', 25),
//       ChartData('Steve', 38),
//       ChartData('Jack', 34),
//       ChartData('Others', 52)
//     ];
//     sessionController = Get.put(SessionController());
//     posSessionsData();
//     SessionService.sessionServiceInstance = null;
//     SessionService.getInstance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.only(top: 16.0.r, right: 32.r, left: 32.r),
//         child: Column(
//           children: [
//             Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               GetBuilder<SessionController>(
//                   id: "Sessionbutton",
//                   builder: (sessioncontroller) {
//                     return Container(
//                         width: 0.3.sw,
//                         height: 0.2.sh,
//                         decoration: BoxDecoration(
//                             color: AppColor.white,
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Column(
//                           children: [
//                             Expanded(
//                                 child: Container(
//                               padding: EdgeInsets.only(
//                                   top: 8.0.r, right: 8.r, left: 8.r),
//                               decoration: BoxDecoration(
//                                   color: AppColor.cyanTeal,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10.r),
//                                     topRight: Radius.circular(10.r),
//                                   )),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SvgPicture.asset(
//                                           'assets/image/pos_icon.svg',
//                                           package: 'yousentech_pos_dashboard',
//                                           clipBehavior: Clip.antiAlias,
//                                           fit: BoxFit.fill,
//                                           width: 0.01.sw,
//                                           height: 0.01.sw,
//                                         ),
//                                         SizedBox(
//                                           height: 0.01.sh,
//                                         ),
//                                         Text(
//                                           SharedPr.currentPosObject!.name
//                                               .toString(),
//                                           style: TextStyle(
//                                               fontSize: 0.01.sw,
//                                               color: AppColor.white,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                         if(SharedPr.currentSaleSession !=null && SharedPr.currentSaleSession!.state== SessionState.openSession)
//                                         Text(
//                                                 "( ${"session_no".tr} : ${SharedPr.currentSaleSession?.id} )",
//                                                 style:
//                                                     AppStyle.stylew400.copyWith(
//                                                   color: AppColor.lavenderGray,
//                                                   fontSize: 7.r,
//                                                 )),
//                                         SizedBox(
//                                           height: 0.01.sh,
//                                         ),
//                                         if (sessionController
//                                             .posSessionsList.isNotEmpty) ...[
//                                           RichText(
//                                             text: TextSpan(
//                                               children: <TextSpan>[
//                                                 TextSpan(
//                                                   text:
//                                                       '${'sessionStartTime'.tr}  ',
//                                                   style: TextStyle(
//                                                       fontSize: 0.008.sw,
//                                                       color: AppColor.darkTeal,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'),
//                                                 ),
//                                                 TextSpan(
//                                                   text: sessionController
//                                                               .posSessionsList
//                                                               .last
//                                                               .startTime !=
//                                                           ''
//                                                       ? intl.DateFormat(
//                                                               'yyyy-MM-dd HH:mm')
//                                                           .format(DateTime.parse(
//                                                               sessionController
//                                                                       .posSessionsList
//                                                                       .last
//                                                                       .startTime ??
//                                                                   ""))
//                                                       : '',
//                                                   style: TextStyle(
//                                                       fontSize: 0.008.sw,
//                                                       color: AppColor.white,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           RichText(
//                                             text: TextSpan(
//                                               children: <TextSpan>[
//                                                 TextSpan(
//                                                   text:
//                                                       '${'sessionCloseTime'.tr}  ',
//                                                   style: TextStyle(
//                                                       fontSize: 0.008.sw,
//                                                       color: AppColor.darkTeal,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'),
//                                                 ),
//                                                 TextSpan(
//                                                   text: sessionController
//                                                               .posSessionsList
//                                                               .last
//                                                               .closeTime !=
//                                                           ''
//                                                       ? intl.DateFormat(
//                                                               'yyyy-MM-dd HH:mm')
//                                                           .format(DateTime.parse(
//                                                               sessionController
//                                                                       .posSessionsList
//                                                                       .last
//                                                                       .closeTime ??
//                                                                   ""))
//                                                       : '',
//                                                   style: TextStyle(
//                                                       fontSize: 0.008.sw,
//                                                       color: AppColor.white,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                       flex: 1,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                           top: 10.0.r,
//                                         ),
//                                         child: SvgPicture.asset(
//                                           'assets/image/pos_image.svg',
//                                           package: 'yousentech_pos_dashboard',
//                                           clipBehavior: Clip.antiAlias,
//                                           matchTextDirection: true,
//                                           fit: BoxFit.fitHeight,
//                                         ),
//                                       ))
//                                 ],
//                               ),
//                             )),
//                             SizedBox(
//                               height: 30.h,
//                               child: Row(
//                                 children: [
//                                   if ((sessionController
//                                               .posSessionsList.isNotEmpty &&
//                                           sessionController
//                                               .checkStartOrResumeSessionAppearance()) ||
//                                       sessionController.posSessionsList.isEmpty)
//                                     Expanded(
//                                       child: InkWell(
//                                         onTap: () {
//                                           sessionController
//                                               .sessionStartOrResumOnTap(
//                                                   context: context);
//                                         },
//                                         child: Center(
//                                           child: Text(
//                                             sessionController
//                                                     .posSessionsList.isEmpty
//                                                 ? "startNewSession".tr
//                                                 : sessionController
//                                                             .posSessionsList
//                                                             .last
//                                                             .state ==
//                                                         SessionState
//                                                             .closedSession
//                                                     ? "startNewSession".tr
//                                                     : "ResumeSession".tr,
//                                             style: TextStyle(
//                                                 fontSize: 10.r,
//                                                 color: AppColor.deepTeal,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   if (sessionController
//                                           .posSessionsList.isNotEmpty &&
//                                       sessionController
//                                               .posSessionsList.last.state !=
//                                           SessionState.closedSession) ...[
//                                     const VerticalDivider(),
//                                     Expanded(
//                                         child: InkWell(
//                                             onTap: () async {
//                                               sessionController
//                                                   .isLoading.value = true;
//                                               await sessioncontroller
//                                                   .uploadData();
//                                               sessionController
//                                                   .isLoading.value = false;
//                                               Get.to(
//                                                   () => SessionCloseScreen2());
//                                             },
//                                             child: Center(
//                                               child: Text(
//                                                 "closeSession".tr,
//                                                 style: TextStyle(
//                                                     fontSize: 10.r,
//                                                     color: AppColor.crimson,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             )))
//                                   ]
//                                 ],
//                               ),
//                             )
//                           ],
//                         ));
//                   }),
//               SizedBox(
//                 width: 10.r,
//               ),
//               // product && customer
//               Cardloadingdata(
//                 e: loaddata.entries
//                     .firstWhere((element) => element.key == Loaddata.products),
//                 menu: SideUserMenu.products,
//                 subtitel:"productess".tr ,
//                 contentpage: const ProductListScreen(),

//               ),
//               SizedBox(
//                 width: 10.r,
//               ),
//               Cardloadingdata(
//                 e: loaddata.entries
//                     .firstWhere((element) => element.key == Loaddata.customers),
//                 menu: SideUserMenu.customers,
//                 subtitel: "custmerss".tr,
//                 contentpage: const CustomersListScreen(),
//               ),
//               // filter
//               const Spacer(),
//               GetBuilder<SessionController>(
//                   id: "Sessionbutton",
//                   builder: (sessioncontroller) {
//                     return Builder(builder: (contextBuilder) {
//                       return InkWell(
//                         onTap: () {
//                           showPopover(
//                             context: contextBuilder,
//                             width: 50.w,
//                             direction: PopoverDirection.bottom,
//                             backgroundColor: AppColor.white,
//                             bodyBuilder: (context) {
//                               return StatefulBuilder(
//                                   builder: (BuildContext context, setState) {
//                                 return SingleChildScrollView(
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       ...dashBoardFilter.map((option) {
//                                         return Column(
//                                           children: [
//                                             ListTile(
//                                               title: Text(
//                                                 option.tr,
//                                                 style: TextStyle(
//                                                   color:
//                                                       const Color(0xff6F6F6F),
//                                                   fontSize: 2.5.sp,
//                                                 ),
//                                               ),
//                                               dense: true,
//                                               visualDensity:
//                                                   const VisualDensity(
//                                                       vertical: -4.0),
//                                               tileColor: _selectedValue ==
//                                                       option
//                                                   ? AppColor
//                                                       .greyWithOpcity // Highlight the selected tile
//                                                   : Colors.transparent,
//                                               onTap: () async {
//                                                 setState(() {
//                                                   _selectedValue = option;
//                                                 });
//                                                 await finalReportController
//                                                     .getFinalReportInfo(
//                                                         dateFilterKey:
//                                                             _selectedValue!);
//                                                 sessioncontroller
//                                                     .update(['Sessionbutton']);
//                                                 Navigator.of(contextBuilder)
//                                                     .pop();
//                                               },
//                                             ),
//                                             Divider(
//                                               height: 0,
//                                               color: AppColor.gray
//                                                   .withOpacity(0.3),
//                                             )
//                                           ],
//                                         );
//                                       })
//                                     ],
//                                   ),
//                                 );
//                               });
//                             },
//                           );
//                         },
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.arrow_drop_down,
//                               color: AppColor.lavenderGray2,
//                               size: 10.r,
//                             ),
//                             SizedBox(
//                               width: 5.r,
//                             ),
//                             Text(
//                               _selectedValue!.tr,
//                               style: TextStyle(color: AppColor.lavenderGray2),
//                             ),
//                             SizedBox(
//                               width: 5.r,
//                             ),
//                             Icon(
//                               FontAwesomeIcons.sliders,
//                               color: Colors.grey,
//                               size: 3.sp,
//                             ),
//                           ],
//                         ),
//                       );
//                     });
//                   })
//             ]),
//             SizedBox(
//               height: 10.r,
//             ),
//             GetBuilder<FinalReportController>(
//                 id: "session_card",
//                 builder: (controller) {
//                   return Row(
//                     children: [
//                       CustomCard(
//                         title: InfoTotalCard.totalSales.text,
//                         total: controller.formatter.format(
//                             controller.finalReportInfo?.totalOutInvoice ?? 0.0),
//                         color: InfoTotalCard.totalSales.color,
//                         icon: InfoTotalCard.totalSales.icon,
//                         isMiddle: false,
//                         height: 0.09.sh,
//                         isdashbord: true,
//                       ),
//                       CustomCard(
//                         title: InfoTotalCard.netIncome.text,
//                         total: controller.formatter.format(
//                             controller.finalReportInfo?.netSales ?? 0.0),
//                         color: InfoTotalCard.netIncome.color,
//                         icon: InfoTotalCard.netIncome.icon,
//                         isMiddle: true,
//                         height: 0.09.sh,
//                         isdashbord: true,
//                       ),
//                       CustomCard(
//                         title: InfoTotalCard.totalReturns.text,
//                         total: controller.formatter.format(
//                             controller.finalReportInfo?.totalOutRefund ?? 0.0),
//                         color: InfoTotalCard.totalReturns.color,
//                         icon: InfoTotalCard.totalReturns.icon,
//                         isdashbord: true,
//                         isMiddle: false,
//                         height: 0.09.sh,
//                         showSendIcon: false,
//                       ),
//                     ],
//                   );
//                 }),
//             SizedBox(
//               height: 10.r,
//             ),
//             //step 3
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GetBuilder<FinalReportController>(
//                     id: "session_card",
//                     builder: (controller) {
//                       return Expanded(
//                         child: Container(
//                             height: 0.2.sh,
//                             padding: EdgeInsets.all(10.r),
//                             decoration: BoxDecoration(
//                                 color: AppColor.white,
//                                 borderRadius: BorderRadius.circular(10.r)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'best_selling_products'.tr,
//                                   style: TextStyle(
//                                       fontSize: 10.r,
//                                       color: AppColor.strongDimGray,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 SizedBox(
//                                   height: 10.r,
//                                 ),
//                                 paymentHeaderRow(header: const [
//                                   'ID',
//                                   'product_name',
//                                   'quantity',
//                                   "price",
//                                   "total"
//                                 ]),
//                                 Expanded(
//                                     child: ListView.separated(
//                                         shrinkWrap: true,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           BasedSellingProduct? item = controller
//                                                       .finalReportInfo ==
//                                                   null
//                                               ? null
//                                               : controller.finalReportInfo!
//                                                   .basedSellingProduct![index];
//                                           List products = item != null
//                                               ? [
//                                                   item.productId,
//                                                   item.getProductNameBasedOnLang,
//                                                   item.totalQty,
//                                                   item.unitPrice,
//                                                   item.totalPrice
//                                                 ]
//                                               : [];
//                                           if (products.isNotEmpty) {
//                                             products[3] = finalReportController
//                                                 .formatter
//                                                 .format(item!.unitPrice);
//                                             products[4] = finalReportController
//                                                 .formatter
//                                                 .format(item.totalPrice);
//                                           }
//                                           return paymentDataRow(
//                                             data: products,
//                                           );
//                                         },
//                                         separatorBuilder: (context, index) {
//                                           return const Divider();
//                                         },
//                                         itemCount: controller.finalReportInfo ==
//                                                 null
//                                             ? 0
//                                             : controller.finalReportInfo!
//                                                         .basedSellingProduct ==
//                                                     null
//                                                 ? 0
//                                                 : controller
//                                                     .finalReportInfo!
//                                                     .basedSellingProduct!
//                                                     .length))
//                               ],
//                             )),
//                       );
//                     }),
//                 SizedBox(
//                   width: 10.r,
//                 ),
//                 GetBuilder<FinalReportController>(
//                     id: "session_card",
//                     builder: (controller) {
//                       var data = controller
//                           .finalReportInfo?.productBasedCategories
//                           ?.map((e) => e.totalQty!)
//                           .toList();
//                       var indector = controller
//                           .finalReportInfo?.productBasedCategories
//                           ?.map((e) => e.getProductNameBasedOnLang)
//                           .toList();
//                       double sum = data == null || data.isEmpty
//                           ? 0.0
//                           : data.reduce((a, b) => a + b);
//                       double opsity = 1;

//                       return Expanded(
//                           child: Container(
//                               height: 0.2.sh,
//                               padding: EdgeInsets.all(10.r),
//                               decoration: BoxDecoration(
//                                   color: AppColor.white,
//                                   borderRadius: BorderRadius.circular(10.r)),
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'best_product_by_cat'.tr,
//                                       style: TextStyle(
//                                           fontSize: 10.r,
//                                           color: AppColor.strongDimGray,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     SizedBox(
//                                       height: 10.r,
//                                     ),
//                                     if (data != null)
//                                       Expanded(
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               ...List.generate(data.length,
//                                                   (index) {
//                                                 opsity -= (opsity /
//                                                     (data.length + 1));
//                                                 return Column(
//                                                   children: [
//                                                     ProgressBarWithText(
//                                                       text:
//                                                           '(${indector![index]}) ${controller.formatter.format((data[index] / sum) * 100)} %',
//                                                       percentage: double.parse(
//                                                           controller.formatter
//                                                               .format(
//                                                                   data[index] /
//                                                                       sum)),
//                                                       backgroundColor:
//                                                           AppColor.cyanTeal,
//                                                       progressColor: AppColor
//                                                           .cyanTeal
//                                                           .withOpacity(opsity),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 1.r,
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                   ])));
//                     }),
//                 SizedBox(
//                   width: 10.r,
//                 ),
//                 GetBuilder<FinalReportController>(
//                     id: "session_card",
//                     builder: (controller) {
//                       return Expanded(
//                           child: Container(
//                               height: 0.2.sh,
//                               padding: EdgeInsets.all(10.r),
//                               decoration: BoxDecoration(
//                                   color: AppColor.white,
//                                   borderRadius: BorderRadius.circular(10.r)),
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'stock_alerts'.tr,
//                                       style: TextStyle(
//                                           fontSize: 10.r,
//                                           color: AppColor.strongDimGray,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     Text(
//                                       "(${"products_about_to_run_out".tr})",
//                                       style: TextStyle(
//                                         fontSize: 8.r,
//                                         color: AppColor.lavenderGray,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 3.r,
//                                     ),
//                                     Expanded(
//                                         child: stockAlertsItem(
//                                             controller: controller)),
//                                   ])));
//                     })
//               ],
//             ),
//             SizedBox(
//               height: 10.r,
//             ),
//             Row(
//               children: [
//                 GetBuilder<FinalReportController>(
//                     id: "session_card",
//                     builder: (controller) {
//                       String theTopSession =
//                           controller.finalReportInfo == null ||
//                                   controller.finalReportInfo!.topSession == null
//                               ? '0'
//                               : controller.finalReportInfo!.topSession!.isEmpty
//                                   ? '0'
//                                   : controller.formatter.format(controller
//                                       .finalReportInfo!
//                                       .topSession!
//                                       .first
//                                       .totalSales!);
//                       return Expanded(
//                         flex: 2,
//                         child: Container(
//                             height: 0.2.sh,
//                             padding: EdgeInsets.all(10.r),
//                             decoration: BoxDecoration(
//                                 color: AppColor.white,
//                                 borderRadius: BorderRadius.circular(10.r)),
//                             child: DefaultTabController(
//                               length: 2,
//                               child: Column(
//                                 children: [
//                                   TabBar(
//                                     onTap: (index) {
//                                       if (index == 0) {
//                                         controller.isbestsellertab.value =
//                                             false;
//                                       } else {
//                                         controller.isbestsellertab.value = true;
//                                       }
//                                       controller.update(["session_card"]);
//                                     },
//                                     indicatorColor: AppColor.cyanTeal,
//                                     tabs: [
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'Top_sales_sessions'.tr,
//                                             style: TextStyle(
//                                                 fontSize: 10.r,
//                                                 color: AppColor.strongDimGray,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                           RichText(
//                                               text:
//                                                   TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: theTopSession,
//                                               style: TextStyle(
//                                                 fontSize: 8.r,
//                                                 color: controller
//                                                         .isbestsellertab.value
//                                                     ? AppColor.strongDimGray
//                                                     : AppColor.cyanTeal,
//                                                 fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'
//                                               ),
//                                             ),
//                                             // get the number
//                                             TextSpan(
//                                               text: ' ${'S.R'.tr}',
//                                               style: TextStyle(
//                                                 fontSize: 8.r,
//                                                 color: AppColor.strongDimGray,
//                                                 fontFamily: 'Tajawal',package: 'yousentech_pos_dashboard'
//                                               ),
//                                             ),
//                                           ])),
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'best_sellers'.tr,
//                                             style: TextStyle(
//                                               fontSize: 10.r,
//                                               fontWeight: FontWeight.w700,
//                                               color: AppColor.strongDimGray,
//                                             ),
//                                           ),
//                                           Text(
//                                             best_seller.first![1].toString(),
//                                             style: TextStyle(
//                                               fontSize: 8.r,
//                                               color: controller
//                                                       .isbestsellertab.value
//                                                   ? AppColor.cyanTeal
//                                                   : AppColor.strongDimGray,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: TabBarView(
//                                       children: [
//                                         // Use PageStorageKey to preserve state
//                                         Column(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(top: 5.r),
//                                               child: paymentHeaderRow(
//                                                 header: const [
//                                                   'session_number',
//                                                   'start_date',
//                                                   'balance_opening',
//                                                   'closingAmount',
//                                                   "salesAmount"
//                                                 ],
//                                                 isbold: false,
//                                               ),
//                                             ),
//                                             Expanded(
//                                                 child: ListView.separated(
//                                                     shrinkWrap: true,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       PosSession? item = controller
//                                                                   .finalReportInfo ==
//                                                               null
//                                                           ? null
//                                                           : controller
//                                                               .finalReportInfo!
//                                                               .topSession![index];
//                                                       List session =
//                                                           item != null
//                                                               ? [
//                                                                   item.id,
//                                                                   item.startTime,
//                                                                   item.balanceOpening,
//                                                                   item.closingAmount,
//                                                                   item.totalSales,
//                                                                 ]
//                                                               : [];
//                                                       if (session.isNotEmpty) {
//                                                         session[1] = DateFormat(
//                                                                 'yyyy-MM-dd')
//                                                             .format(DateTime
//                                                                 .parse(item!
//                                                                     .startTime!));
//                                                         session[2] =
//                                                             finalReportController
//                                                                 .formatter
//                                                                 .format(item
//                                                                     .balanceOpening);

//                                                         session[3] =
//                                                             finalReportController
//                                                                 .formatter
//                                                                 .format(item
//                                                                     .closingAmount);
//                                                         session[4] =
//                                                             finalReportController
//                                                                 .formatter
//                                                                 .format(item
//                                                                     .totalSales);
//                                                       }
//                                                       return Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 1.r),
//                                                         child: paymentDataRow(
//                                                           data: session,
//                                                         ),
//                                                       );
//                                                     },
//                                                     separatorBuilder:
//                                                         (context, index) {
//                                                       return const Divider(
//                                                           // height: 50.r,
//                                                           );
//                                                     },
//                                                     itemCount: controller
//                                                                 .finalReportInfo ==
//                                                             null
//                                                         ? 0
//                                                         : controller.finalReportInfo!
//                                                                     .topSession ==
//                                                                 null
//                                                             ? 0
//                                                             : controller
//                                                                 .finalReportInfo!
//                                                                 .topSession!
//                                                                 .length))
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(top: 5.r),
//                                               child: paymentHeaderRow(
//                                                 header: const [
//                                                   'NO',
//                                                   'name',
//                                                   'total_sales',
//                                                   'no_sessions',
//                                                 ],
//                                                 isbold: false,
//                                               ),
//                                             ),
//                                             Expanded(
//                                                 child: ListView.separated(
//                                                     shrinkWrap: true,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       return Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 1.r),
//                                                         child: paymentDataRow(
//                                                           data:
//                                                               best_seller[index]
//                                                                   as List,
//                                                         ),
//                                                       );
//                                                     },
//                                                     separatorBuilder:
//                                                         (context, index) {
//                                                       return Divider(
//                                                           // height: 5.r,
//                                                           );
//                                                     },
//                                                     itemCount:
//                                                         best_seller.length)),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       );
//                     }),
//                 SizedBox(
//                   width: 10.r,
//                 ),
//                 // payment Method
//                 GetBuilder<FinalReportController>(
//                     id: "session_card",
//                     builder: (controller) {
//                       return Expanded(
//                         flex: 1,
//                         child: Container(
//                             height: 0.2.sh,
//                             padding: EdgeInsets.all(10.r),
//                             decoration: BoxDecoration(
//                                 color: AppColor.white,
//                                 borderRadius: BorderRadius.circular(10.r)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'payment_methods'.tr,
//                                   style: TextStyle(
//                                       fontSize: 10.r,
//                                       color: AppColor.strongDimGray,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 SizedBox(
//                                   height: 10.r,
//                                 ),
//                                 paymentHeaderRow(header: const [
//                                   'paymentType',
//                                   'total',
//                                   'num_times'
//                                 ]),
//                                 Expanded(
//                                     child: ListView.separated(
//                                         shrinkWrap: true,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           String name = SharedPr.lang == "ar"
//                                               ? finalReportController
//                                                   .invoicePaymentMethod[index]
//                                                   .accountJournalName
//                                                   .ar001
//                                               : finalReportController
//                                                   .invoicePaymentMethod[index]
//                                                   .accountJournalName
//                                                   .enUS;
//                                           String amount = finalReportController
//                                               .formatter
//                                               .format(finalReportController
//                                                   .invoicePaymentMethod[index]
//                                                   .totalAmount);
//                                           String invoiceCount =
//                                               finalReportController
//                                                   .invoicePaymentMethod[index]
//                                                   .invoiceCount
//                                                   .toString();
//                                           List item = [
//                                             name,
//                                             amount,
//                                             invoiceCount
//                                           ];
//                                           return paymentDataRow(
//                                             data: item,
//                                             icon: finalReportController
//                                                         .invoicePaymentMethod[
//                                                             index]
//                                                         .type ==
//                                                     PaymentType.cash.name
//                                                 ? 'assets/image/cash.svg'
//                                                 : finalReportController
//                                                             .invoicePaymentMethod[
//                                                                 index]
//                                                             .type ==
//                                                         PaymentType.bank.name
//                                                     ? 'assets/image/credit_card.svg'
//                                                     : 'assets/image/wallet.svg',
//                                             isPymentMethod: true,
//                                           );
//                                         },
//                                         separatorBuilder: (context, index) {
//                                           return const Divider();
//                                         },
//                                         itemCount: controller
//                                             .invoicePaymentMethod.length))
//                               ],
//                             )),
//                       );
//                     }),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// stockAlertsItem({required FinalReportController controller}) {
//   var length = controller.finalReportInfo == null
//       ? 0
//       : controller.finalReportInfo!.lessProductsBasedInAvailableQty == null
//           ? 0
//           : controller.finalReportInfo!.lessProductsBasedInAvailableQty!.length;

//   return SingleChildScrollView(
//     child: Column(children: [
//       Row(children: [
//         Expanded(
//           child: Text(
//             "product_name".tr,
//             style: TextStyle(
//                 fontSize: 7.r,
//                 color: AppColor.strongDimGray,
//                 fontWeight: FontWeight.w700),
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: Center(
//             child: Text(
//               'remaining_quantity'.tr,
//               style: TextStyle(
//                   fontSize: 7.r,
//                   color: AppColor.strongDimGray,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//         ),
//       ]),
//       SizedBox(
//         height: 5.r,
//       ),
//       const Divider(
//         height: 0,
//       ),
//       ...List.generate(length, (index) {
//         LessProductsBasedInAvailableQty? item =
//             controller.finalReportInfo == null
//                 ? null
//                 : controller
//                     .finalReportInfo!.lessProductsBasedInAvailableQty![index];
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 5.r,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     item?.getProductNameBasedOnLang ?? "",
//                     style: TextStyle(
//                         fontSize: 7.r,
//                         color: AppColor.strongDimGray,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text(
//                       '${item?.availableQty ?? ""} ${'packs'.tr}',
//                       style: TextStyle(
//                           fontSize: 7.r,
//                           color: AppColor.strongDimGray,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.r,
//             ),
//             if (index != length - 1)
//               const Divider(
//                 height: 0,
//               )
//           ],
//         );
//       }),
//     ]),
//   );
// }

// class paymentHeaderRow extends StatelessWidget {
//   paymentHeaderRow({super.key, required this.header, this.isbold = true});
//   bool isbold;
//   List header;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             ...header.map(
//               (e) => Expanded(
//                 child: Center(
//                   child: Text(
//                     e.toString().tr,
//                     style: TextStyle(
//                         fontSize: 7.r,
//                         color: AppColor.strongDimGray,
//                         fontWeight:
//                             isbold ? FontWeight.w700 : FontWeight.normal),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         const Divider()
//       ],
//     );
//   }
// }

// class SellerHeaderRow extends StatelessWidget {
//   SellerHeaderRow({
//     super.key,
//     required this.data,
//   });

//   List data;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 10.h,
//       child: Row(
//         children: [
//           ...List.generate(
//             data.length,
//             (index) => index == 0
//                 ? Expanded(
//                     child: Container(
//                       height: 20.h,
//                       alignment: Alignment.center,
//                       color: AppColor.greyWithOpcity,
//                       child: Text(
//                         '${data[index]}',
//                         style: TextStyle(
//                           fontSize: 7.r,
//                           color: AppColor.strongDimGray,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Expanded(
//                     child: Container(
//                       height: 10.h,
//                       alignment: Alignment.center,
//                       child: Text(
//                         '${data[index]}',
//                         style: TextStyle(
//                           fontSize: 7.r,
//                           color: AppColor.charcoalGray,
//                         ),
//                       ),
//                     ),
//                   ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class paymentDataRow extends StatelessWidget {
//   paymentDataRow(
//       {super.key,
//       required this.data,
//       this.isPymentMethod = false,
//       this.isSeller = false,
//       this.icon = ''});

//   List data;
//   String icon;
//   bool isPymentMethod, isSeller;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ...List.generate(
//           data.length,
//           (index) => index == 0 && isPymentMethod
//               ? Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         icon,
//                         package: 'yousentech_pos_dashboard',
//                         clipBehavior: Clip.antiAlias,
//                         fit: BoxFit.fill,
//                         width: 10.r,
//                         height: 10.r,
//                       ),
//                       SizedBox(
//                         width: 10.r,
//                       ),
//                       Tooltip(
//                         message: '${data[index]}',
//                         child: Text(
//                           '${data[index]}',
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 7.r,
//                             color: AppColor.strongDimGray,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Expanded(
//                   child: Center(
//                     child: Tooltip(
//                       message:
//                           '${data[index]} ${isPymentMethod && index == 1 ? "S.R".tr : ''}',
//                       child: Text(
//                         '${data[index]} ${isPymentMethod && index == 1 ? "S.R".tr : ''}',
//                         style: TextStyle(
//                           fontSize: 7.r,
//                           overflow: TextOverflow.ellipsis,
//                           color: isPymentMethod
//                               ? index == 1
//                                   ? AppColor.cyanTeal
//                                   : AppColor.strongDimGray
//                               : AppColor.charcoalGray,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//         )
//       ],
//     );
//   }
// }

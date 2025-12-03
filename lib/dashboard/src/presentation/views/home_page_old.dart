// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:pos_shared_preferences/pos_shared_preferences.dart';
// import 'package:shared_widgets/config/app_colors.dart';
// import 'package:shared_widgets/shared_widgets/custom_app_bar.dart';
// import 'package:shared_widgets/utils/screens_size.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/account_journal/presentation/account_journal_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/account_tax/presentation/account_tax_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/customer/presentation/views/customers_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/pos_categories/presentation/pos_categories_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/product_unit/presentation/pos_product_unit_list_screen.dart';
// import 'package:yousentech_pos_basic_data_management/basic_data_management/src/products/presentation/product_list_screen.dart';
// import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';
// import 'package:yousentech_pos_dashboard/dashboard/config/app_list.dart';
// import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/user_dashboard_screen.dart';
// import 'package:yousentech_pos_invoice/invoices/presentation/return_invoice_preparation_screen.dart';
// import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
// import 'package:yousentech_pos_notification_history/notification_history/presentation/widgets/expandable_message_widget.dart';
// import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
// import 'package:yousentech_pos_session_list_with_report/sessions_list_with_report/presentation/session_list_screen.dart';
// import '../../domain/dashboard_viewmodel.dart';
// import '../widgets/progress_bar.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   DashboardController dashboardController =
//       Get.put(DashboardController.getInstance());
//   LoadingDataController loadingDataController =
//       Get.put(LoadingDataController());

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late TabController _tabController;
//   updatecontent() {
//     dashboardController.update(['UserMenu']);
//     loadingDataController.update(['loadings']);
//     loadingDataController.update(['card_loading_data']);
//     dashboardController.update(['content']);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//         length: dashboardController.selectedMenulength, vsync: this);
//   }

//   updateSelectedMenu(
//       {required SideUserMenu menu, required Widget contentpage}) {
//     dashboardController.updateSelectedMenu(sideUserMenu: menu);
//     dashboardController.selectedMenulength =
//         sideUserMenu[dashboardController.selectedMenu]!.length;
//     _tabController = TabController(
//         length: dashboardController.selectedMenulength, vsync: this);
//     dashboardController.content = contentpage;
//     dashboardController.selectedSubMenu =
//         sideUserMenu[dashboardController.selectedMenu]!.isNotEmpty ? 0 : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: AppColor.ghostWhite,
//         appBar: customAppBar(headerBackground: true),
//         body: Container(
//           decoration: BoxDecoration(color: AppColor.ghostWhite),
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   // THE CONTENT
//                   Expanded(
//                     child: GetBuilder<LoadingDataController>(
//                         id: "loading",
//                         builder: (loadingcontext) {
//                           return loadingDataController.isLoad.value
//                               ? const ProgressWidget()
//                               : GetBuilder<DashboardController>(
//                                   id: "content",
//                                   builder: (contentcontext) {
//                                     return sideUserMenu[dashboardController
//                                                 .selectedMenu]!
//                                             .isNotEmpty
//                                         ? Column(
//                                             children: [
//                                               SizedBox(
//                                                 height: Get.height * 0.06,
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                     MediaQuery.of(context)
//                                                             .size
//                                                             .width /
//                                                         8,
//                                                 child: TabBar(
//                                                   controller: _tabController,
//                                                   //  TabController(
//                                                   //     length: dashboardController
//                                                   //         .selectedMenulength,
//                                                   //     vsync: this),
//                                                   onTap: (index) {
//                                                     dashboardController
//                                                             .selectedSubMenu =
//                                                         index;
//                                                     updatecontent();
//                                                   },
//                                                   tabs: <Widget>[
//                                                     ...sideUserMenu[
//                                                             dashboardController
//                                                                 .selectedMenu]!
//                                                         .map(
//                                                       (e) {
//                                                         //selectedMenu
//                                                         var indexof = sideUserMenu[
//                                                                 dashboardController
//                                                                     .selectedMenu]!
//                                                             .indexOf(e);
//                                                         return Tab(
//                                                           iconMargin:
//                                                               const EdgeInsets
//                                                                   .all(0),
//                                                           height:
//                                                               Get.height * 0.06,
//                                                           icon: e.last.first
//                                                                   is IconData
//                                                               ? Icon(
//                                                                   e.last.first,
//                                                                   size: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .height *
//                                                                       0.03,
//                                                                   color: dashboardController
//                                                                               .selectedSubMenu ==
//                                                                           indexof
//                                                                       ? AppColor
//                                                                           .purple
//                                                                       : AppColor
//                                                                           .black,
//                                                                 )
//                                                               : Image.asset(
//                                                                   "assets/image/${e.last.first}.png",
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .height *
//                                                                       0.03,
//                                                                   color: dashboardController
//                                                                               .selectedSubMenu ==
//                                                                           indexof
//                                                                       ? AppColor
//                                                                           .purple
//                                                                       : AppColor
//                                                                           .black,
//                                                                 ),
//                                                           text: e.first
//                                                               .toString()
//                                                               .tr,
//                                                         );
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 // height: MediaQuery.of(context)
//                                                 //         .size
//                                                 //         .height -
//                                                 //     (Get.height * 0.05 +
//                                                 //         Get.height * 0.09),
//                                                 // width: MediaQuery.of(context)
//                                                 //         .size
//                                                 //         .width -
//                                                 //     MediaQuery.of(context)
//                                                 //             .size
//                                                 //             .width /
//                                                 //         8,
//                                                 child: TabBarView(
//                                                   controller: _tabController,
//                                                   // TabController(
//                                                   //     length: dashboardController
//                                                   //         .selectedMenulength,
//                                                   //     vsync: this),
//                                                   children: <Widget>[
//                                                     ...sideUserMenu[
//                                                             dashboardController
//                                                                 .selectedMenu]!
//                                                         .map((e) {
//                                                       // print("e$e");
//                                                       return e.last.last;
//                                                     }),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         : dashboardController.content;
//                                   });
//                         }),
//                   ),

//                   /// THE MENU
//                   GetBuilder<LoadingDataController>(
//                       id: "loading",
//                       builder: (loadingcontext) {
//                         // print(loadingDataController.isLoad.value);
//                         return Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Padding(
//                             padding: EdgeInsets.all(16.0.r),
//                             child: ScreenSizeHelper().isScreenLessThan11Inches()
//                                 ? Container(
//                                     width: 0.7.sw,
//                                     height: 0.07.sh,
//                                     padding: EdgeInsets.all(5.r),
//                                     decoration: BoxDecoration(
//                                       color: AppColor.cyanTeallite,
//                                       borderRadius: BorderRadius.circular(13.r),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.dashboard,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.dashboard,
//                                                 contentpage:
//                                                     const UserDashboard());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'dashboard_icon',
//                                           title: 'dashboard',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.products,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.products,
//                                                 contentpage:
//                                                     const ProductListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'product_menu_icon',
//                                           title: 'products',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.customers,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.customers,
//                                                 contentpage:
//                                                     const CustomersListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'customers',
//                                           title: 'customers',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.categories,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.categories,
//                                                 contentpage:
//                                                     const PosCategoryListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'categories_menu_icon',
//                                           title: 'categories',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.units,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.units,
//                                                 contentpage:
//                                                     const PosProductUnitListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'productunit_menu_icon',
//                                           title: 'product_unit',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.accountTax,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.accountTax,
//                                                 contentpage:
//                                                     const PosAccountTaxListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'product_tax_menu_icon',
//                                           title: 'taxes',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.accountJournal,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu:
//                                                     SideUserMenu.accountJournal,
//                                                 contentpage:
//                                                     const PosAccountJournalListScreen());
//                                             updatecontent();
//                                           },
//                                           showtitel: false,
//                                           icon: 'calculate_menu_icon',
//                                           title: 'pos_account_journal_list',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.invoiceReturn,
//                                           onTap: () {
//                                             Get.put(SessionController())
//                                                 .isPosted
//                                                 .value = true;
//                                             Get.put(SessionController())
//                                                 .isPreviousScreen
//                                                 .value = false;

//                                             updateSelectedMenu(
//                                                 menu:
//                                                     SideUserMenu.invoiceReturn,
//                                                 contentpage:
//                                                     const PreviousInvoiceScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'refun_invoice',
//                                           showtitel: false,
//                                           title: 'invoice_return_n',
//                                         ),
//                                         if (SharedPr.userObj!
//                                             .showFinalReportForAllSessions!) ...[
//                                           menuContent(
//                                             selectedsideUserMenu:
//                                                 SideUserMenu.reports,
//                                             onTap: () {
//                                               updateSelectedMenu(
//                                                   menu: SideUserMenu.reports,
//                                                   contentpage:
//                                                       SessionListScreen());
//                                               updatecontent();
//                                             },
//                                             showtitel: false,
//                                             icon: 'reports_menu_icon',
//                                             title: 'Reports',
//                                           ),
//                                         ],
//                                       ],
//                                     ),
//                                   )
//                                 : Container(
//                                     width: 0.7.sw,
//                                     height: 0.07.sh,
//                                     padding: EdgeInsets.all(5.r),
//                                     decoration: BoxDecoration(
//                                       color: AppColor.white,
//                                       borderRadius: BorderRadius.circular(10.r),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.dashboard,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.dashboard,
//                                                 contentpage:
//                                                     const UserDashboard());
//                                             updatecontent();
//                                           },
//                                           icon: 'dashboard_icon',
//                                           title: 'dashboard',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.products,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.products,
//                                                 contentpage:
//                                                     const ProductListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'product_menu_icon',
//                                           title: 'products',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.customers,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.customers,
//                                                 contentpage:
//                                                     const CustomersListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'customers',
//                                           title: 'customers',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.categories,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.categories,
//                                                 contentpage:
//                                                     const PosCategoryListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'categories_menu_icon',
//                                           title: 'categories',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.units,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.units,
//                                                 contentpage:
//                                                     const PosProductUnitListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'productunit_menu_icon',
//                                           title: 'product_unit',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.accountTax,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu: SideUserMenu.accountTax,
//                                                 contentpage:
//                                                     const PosAccountTaxListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'product_tax_menu_icon',
//                                           title: 'taxes',
//                                         ),
//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.accountJournal,
//                                           onTap: () {
//                                             updateSelectedMenu(
//                                                 menu:
//                                                     SideUserMenu.accountJournal,
//                                                 contentpage:
//                                                     const PosAccountJournalListScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'calculate_menu_icon',
//                                           title: 'pos_account_journal_list',
//                                         ),

//                                         menuContent(
//                                           selectedsideUserMenu:
//                                               SideUserMenu.invoiceReturn,
//                                           onTap: () {
//                                             Get.put(SessionController())
//                                                 .isPosted
//                                                 .value = true;
//                                             Get.put(SessionController())
//                                                 .isPreviousScreen
//                                                 .value = false;

//                                             updateSelectedMenu(
//                                                 menu:
//                                                     SideUserMenu.invoiceReturn,
//                                                 contentpage:
//                                                     const PreviousInvoiceScreen());
//                                             updatecontent();
//                                           },
//                                           icon: 'refun_invoice',
//                                           title: 'invoice_return_n',
//                                         ),
//                                         if (SharedPr.userObj!
//                                             .showFinalReportForAllSessions!) ...[
//                                           menuContent(
//                                             selectedsideUserMenu:
//                                                 SideUserMenu.reports,
//                                             onTap: () {
//                                               updateSelectedMenu(
//                                                   menu: SideUserMenu.reports,
//                                                   contentpage:
//                                                       SessionListScreen());
//                                               updatecontent();
//                                             },
//                                             icon: 'reports_menu_icon',
//                                             title: 'Reports',
//                                           ),
//                                         ],
//                                         // menuContent(
//                                         //   selectedsideUserMenu:
//                                         //       SideUserMenu.configuration,
//                                         //   onTap: () {
//                                         //     updateSelectedMenu(
//                                         //         menu:
//                                         //             SideUserMenu.configuration,
//                                         //         contentpage: Container());
//                                         //     updatecontent();
//                                         //   },
//                                         //   icon: 'setting_menu_icon',
//                                         //   title: 'Settings',
//                                         // ),
//                                         // menuContent(
//                                         //   selectedsideUserMenu:
//                                         //       SideUserMenu.databaseInfoSetting,
//                                         //   onTap: () async {
//                                         //     updateSelectedMenu(
//                                         //         menu: SideUserMenu.databaseInfoSetting,
//                                         //         contentpage: const ShowLoadedData());
//                                         //     updatecontent();
//                                         //   },
//                                         //   icon: 'database_menu_icon',
//                                         //   title: 'Database_Info_Setting',
//                                         // ),
//                                         // menuContent(
//                                         //   selectedsideUserMenu:
//                                         //       SideUserMenu.dataManagement,
//                                         //   onTap: () async {
//                                         //     updateSelectedMenu(
//                                         //         menu:
//                                         //             SideUserMenu.dataManagement,
//                                         //         contentpage: Container());
//                                         //     updatecontent();
//                                         //   },
//                                         //   icon: 'management_menu_icon',
//                                         //   title: 'data_Management',
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                           ),
//                         );
//                       })
//                 ],
//               ),
//               const ExpandableMessageWidget()
//               // Padding(
//               //   padding: const EdgeInsets.all(20.0),
//               //   child: Align(
//               //       alignment: SharedPr.lang == "ar" ? Alignment.bottomLeft : Alignment.bottomRight,
//               //       child: const ExpandableMessageWidget()),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget menuContent({
//     required icon,
//     required void Function()? onTap,
//     required String title,
//     bool showtitel = true,
//     required SideUserMenu selectedsideUserMenu,
//   }) {
//     return GetBuilder<DashboardController>(
//         id: "UserMenu",
//         builder: (_) {
//           bool isselected =
//               selectedsideUserMenu == dashboardController.selectedMenu;
//           return InkWell(
//             onTap: onTap,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 3.r),
//               decoration: BoxDecoration(
//                   color: !showtitel
//                       ? null
//                       : isselected
//                           ? AppColor.cyanTeal.withOpacity(0.1)
//                           : null,
//                   borderRadius:
//                       isselected ? BorderRadius.circular(10.r) : null),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   icon is IconData
//                       ? Icon(
//                           icon,
//                           size: showtitel ? 15.r : 20.r,
//                           color: !showtitel
//                               ? isselected
//                                   ? AppColor.cyanTeal
//                                   : AppColor.white
//                               : AppColor.cyanTeal,
//                           // color: dashboardController.selectedMenu ==
//                           //         selectedsideUserMenu
//                           //     ? AppColor.purple
//                           //     : AppColor.iconsMenu,
//                         )
//                       : SvgPicture.asset(
//                           "assets/image/$icon.svg",
//                           package: 'yousentech_pos_dashboard',
//                           width: showtitel ? 15.r : 20.r,
//                           height: showtitel ? 15.r : 20.r,
//                           color: !showtitel
//                               ? isselected
//                                   ? AppColor.cyanTeal
//                                   : AppColor.white
//                               : AppColor.cyanTeal,
//                           // color: dashboardController.selectedMenu ==
//                           //         selectedsideUserMenu
//                           //     ? AppColor.iconsMenuActavit
//                           //     : AppColor.iconsMenu,
//                         ),
//                   showtitel
//                       ? Text(
//                           title.tr,
//                           style: TextStyle(
//                               fontSize: 8.r,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.cyanTeal),
//                         )
//                       : Container()
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }








// //           _newbuildMenuIcon(null, 'data-management', () async {
// //             updateSelectedMenu(
// //                 menu: SideUserMenu.dataManagement, contentpage: Container());
// //             updatecontent();
// //           }, 'data_Management', false, SideUserMenu.dataManagement),
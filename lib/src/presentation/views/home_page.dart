import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/shared_widgets/custom_app_bar.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/account_journal/presentation/account_journal_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/account_tax/presentation/account_tax_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/customer/presentation/views/customers_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/pos_categories/presentation/views/pos_categories_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/product_unit/presentation/pos_product_unit_list_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/products/presentation/views/product_list_screen.dart';
import 'package:yousentech_pos_dashboard/config/app_enums.dart';
import 'package:yousentech_pos_dashboard/config/app_list.dart';
import 'package:yousentech_pos_dashboard/src/presentation/views/user_dashboard_screen.dart';
import 'package:yousentech_pos_loading_synchronizing_data/yousentech_pos_loading_synchronizing_data.dart';
import '../../domain/dashboard_viewmodel.dart';
import '../widgets/progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DashboardController dashboardController =
      Get.put(DashboardController.getInstance());
  LoadingDataController loadingDataController =
      Get.put(LoadingDataController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  updatecontent() {
    dashboardController.update(['UserMenu']);
    loadingDataController.update(['loadings']);
    loadingDataController.update(['card_loading_data']);
    dashboardController.update(['content']);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: dashboardController.selectedMenulength, vsync: this);
  }

  updateSelectedMenu(
      {required SideUserMenu menu, required Widget contentpage}) {
    dashboardController.updateSelectedMenu(sideUserMenu: menu);
    dashboardController.selectedMenulength =
        sideUserMenu[dashboardController.selectedMenu]!.length;
    _tabController = TabController(
        length: dashboardController.selectedMenulength, vsync: this);
    dashboardController.content = contentpage;
    dashboardController.selectedSubMenu =
        sideUserMenu[dashboardController.selectedMenu]!.isNotEmpty ? 0 : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.ghostWhite,
      appBar: customAppBar(headerBackground: true),
      body: Container(
        decoration: BoxDecoration(color: AppColor.ghostWhite),
        child: Stack(
          children: [
            Column(
              children: [
                // THE CONTENT
                Expanded(
                  child: GetBuilder<LoadingDataController>(
                      id: "loading",
                      builder: (loadingcontext) {
                        // print(loadingDataController.isLoad.value);
                        return loadingDataController.isLoad.value
                            ? const ProgressWidget()
                            : GetBuilder<DashboardController>(
                                id: "content",
                                builder: (contentcontext) {
                                  return sideUserMenu[
                                              dashboardController.selectedMenu]!
                                          .isNotEmpty
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.06,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                              child: TabBar(
                                                controller: _tabController,
                                                //  TabController(
                                                //     length: dashboardController
                                                //         .selectedMenulength,
                                                //     vsync: this),
                                                onTap: (index) {
                                                  dashboardController
                                                      .selectedSubMenu = index;
                                                  updatecontent();
                                                },
                                                tabs: <Widget>[
                                                  ...sideUserMenu[
                                                          dashboardController
                                                              .selectedMenu]!
                                                      .map(
                                                    (e) {
                                                      //selectedMenu
                                                      var indexof = sideUserMenu[
                                                              dashboardController
                                                                  .selectedMenu]!
                                                          .indexOf(e);
                                                      return Tab(
                                                        iconMargin:
                                                            const EdgeInsets
                                                                .all(0),
                                                        height:
                                                            Get.height * 0.06,
                                                        icon:
                                                            e.last.first
                                                                    is IconData
                                                                ? Icon(
                                                                    e.last
                                                                        .first,
                                                                    size: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.03,
                                                                    color: dashboardController.selectedSubMenu ==
                                                                            indexof
                                                                        ? AppColor
                                                                            .purple
                                                                        : AppColor
                                                                            .black,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/image/${e.last.first}.png",
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.03,
                                                                    color: dashboardController.selectedSubMenu ==
                                                                            indexof
                                                                        ? AppColor
                                                                            .purple
                                                                        : AppColor
                                                                            .black,
                                                                  ),
                                                        text: e.first
                                                            .toString()
                                                            .tr,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height -
                                              //     (Get.height * 0.05 +
                                              //         Get.height * 0.09),
                                              // width: MediaQuery.of(context)
                                              //         .size
                                              //         .width -
                                              //     MediaQuery.of(context)
                                              //             .size
                                              //             .width /
                                              //         8,
                                              child: TabBarView(
                                                controller: _tabController,
                                                // TabController(
                                                //     length: dashboardController
                                                //         .selectedMenulength,
                                                //     vsync: this),
                                                children: <Widget>[
                                                  ...sideUserMenu[
                                                          dashboardController
                                                              .selectedMenu]!
                                                      .map((e) {
                                                    // print("e$e");
                                                    return e.last.last;
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : dashboardController.content;
                                });
                      }),
                ),

                /// THE MENU
                GetBuilder<LoadingDataController>(
                    id: "loading",
                    builder: (loadingcontext) {
                      // print(loadingDataController.isLoad.value);
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(16.0.r),
                          child: Container(
                            width: 0.7.sw,
                            height: 0.07.sh,
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10.r),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black
                              //         .withOpacity(0.1), // يمكنك تغيير لون الظل
                              //     offset: const Offset(2, 2), // تحديد موضع الظل
                              //     blurRadius: 4.0, // تحديد درجة تشويش الظل
                              //     spreadRadius: 1.0, // تحديد مدى امتداد الظل
                              //   ),
                              // ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.dashboard,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.dashboard,
                                        contentpage: const UserDashboard());
                                    updatecontent();
                                  },
                                  icon: 'dashboard_icon',
                                  title: 'dashboard',
                                ),
                                // menuContent(
                                //   selectedsideUserMenu: SideUserMenu.pointOfSale,
                                //   onTap: () {
                                //     updateSelectedMenu(
                                //         menu: SideUserMenu.pointOfSale,
                                //         contentpage: const InvoiceScreen());
                                //     updatecontent();
                                //   },
                                //   icon: 'reservation-orders',
                                //   title: 'pointOfSale',
                                // ),
                                // menuContent(
                                //   selectedsideUserMenu: SideUserMenu.orders,
                                //   onTap: () {
                                //     updateSelectedMenu(
                                //         menu: SideUserMenu.orders,
                                //         contentpage: const InvoiceScreen());
                                //     updatecontent();
                                //   },
                                //   icon: 'reservation-orders',
                                //   title: 'orders',
                                // ),
                                ///////////////////////////////////
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.products,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.products,
                                        contentpage: const ProductListScreen());
                                    updatecontent();
                                  },
                                  icon: 'product_menu_icon',
                                  title: 'products',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.customers,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.customers,
                                        contentpage:
                                            const CustomersListScreen());
                                    updatecontent();
                                  },
                                  icon: 'customers',
                                  title: 'customers',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.categories,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.categories,
                                        contentpage:
                                            const PosCategoryListScreen());
                                    updatecontent();
                                  },
                                  icon: 'categories_menu_icon',
                                  title: 'categories',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.units,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.units,
                                        contentpage:
                                            const PosProductUnitListScreen());
                                    updatecontent();
                                  },
                                  icon: 'productunit_menu_icon',
                                  title: 'product_unit',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.accountTax,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.accountTax,
                                        contentpage:
                                            const PosAccountTaxListScreen());
                                    updatecontent();
                                  },
                                  icon: 'product_tax_menu_icon',
                                  title: 'taxes',
                                ),
                                menuContent(
                                  selectedsideUserMenu:
                                      SideUserMenu.accountJournal,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.accountJournal,
                                        contentpage:
                                            const PosAccountJournalListScreen());
                                    updatecontent();
                                  },
                                  icon: 'calculate_menu_icon',
                                  title: 'pos_account_journal_list',
                                ),
                                
                                if (SharedPr.userObj!
                                    .showFinalReportForAllSessions!) ...[
                                  menuContent(
                                    selectedsideUserMenu: SideUserMenu.reports,
                                    onTap: () {
                                      // TODO :ADD AFTER SessionList
                                      // updateSelectedMenu(
                                      //     menu: SideUserMenu.reports,
                                      //     contentpage: SessionListScreen());
                                      // updatecontent();
                                    },
                                    icon: 'reports_menu_icon',
                                    title: 'Reports',
                                  ),
                                ],
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.configuration,
                                  onTap: () {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.configuration,
                                        contentpage: Container());
                                    updatecontent();
                                  },
                                  icon: 'setting_menu_icon',
                                  title: 'Settings',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.databaseInfoSetting,
                                  onTap: () async {
                                    // TODO :ADD AFTER SessionList
                                    // updateSelectedMenu(
                                    //     menu: SideUserMenu.databaseInfoSetting,
                                    //     contentpage: const ShowLoadedData());
                                    // updatecontent();
                                  },
                                  icon: 'database_menu_icon',
                                  title: 'Database_Info_Setting',
                                ),
                                menuContent(
                                  selectedsideUserMenu: SideUserMenu.dataManagement,
                                  onTap: () async {
                                    updateSelectedMenu(
                                        menu: SideUserMenu.dataManagement,
                                        contentpage: Container());
                                    updatecontent();
                                  },
                                  icon: 'management_menu_icon',
                                  title: 'data_Management',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
            // TODO :AFTER NOTFICATION
            // const ExpandableMessageWidget()
            // END
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Align(
            //       alignment: SharedPr.lang == "ar" ? Alignment.bottomLeft : Alignment.bottomRight,
            //       child: const ExpandableMessageWidget()),
            // ),
          ],
        ),
      ),
    );
  }

  Widget menuContent({
    required icon,
    required void Function()? onTap,
    required String title,
    required SideUserMenu selectedsideUserMenu,
  }) {
    return GetBuilder<DashboardController>(
        id: "UserMenu",
        builder: (_) {
          bool isselected =
              selectedsideUserMenu == dashboardController.selectedMenu;
          return InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.r),
              decoration: BoxDecoration(
                  color: isselected ? AppColor.cyanTeal.withOpacity(0.1) : null,
                  borderRadius:
                      isselected ? BorderRadius.circular(10.r) : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon is IconData
                      ? Icon(
                          icon,
                          size: 10.r,
                          color: AppColor.cyanTeal,
                          // color: dashboardController.selectedMenu ==
                          //         selectedsideUserMenu
                          //     ? AppColor.purple
                          //     : AppColor.iconsMenu,
                        )
                      : SvgPicture.asset(
                          "assets/image/$icon.svg",
                          width: 15.r,
                          height: 15.r,
                          color: AppColor.cyanTeal,
                          // color: dashboardController.selectedMenu ==
                          //         selectedsideUserMenu
                          //     ? AppColor.iconsMenuActavit
                          //     : AppColor.iconsMenu,
                        ),
                  Text(
                    title.tr,
                    style: TextStyle(
                        fontSize: 8.r,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cyanTeal),
                  )
                ],
              ),
            ),
          );
        });
  }
}








//           _newbuildMenuIcon(null, 'data-management', () async {
//             updateSelectedMenu(
//                 menu: SideUserMenu.dataManagement, contentpage: Container());
//             updatecontent();
//           }, 'data_Management', false, SideUserMenu.dataManagement),
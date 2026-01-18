// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pos_shared_preferences/pos_shared_preferences.dart';
import 'package:shared_widgets/config/app_colors.dart';
import 'package:shared_widgets/config/app_images.dart';
import 'package:shared_widgets/config/theme_controller.dart';
import 'package:shared_widgets/shared_widgets/custom_app_bar.dart';
import 'package:shared_widgets/utils/responsive_helpers/device_utils.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_helper_extenstions.dart';
import 'package:shared_widgets/utils/responsive_helpers/size_provider.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/customer/presentation/views/customer_screen.dart';
import 'package:yousentech_pos_basic_data_management/basic_data_management/src/products/presentation/product_screen.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/views/dashboard.dart';
import 'package:yousentech_pos_dashboard/dashboard/src/presentation/widgets/progress_bar.dart';
import 'package:yousentech_pos_loading_synchronizing_data/loading_sync/src/domain/loading_synchronizing_data_viewmodel.dart';
import 'package:yousentech_pos_session_list_with_report/sessions_list_with_report/presentation/report_session.dart';
import 'package:yousentech_pos_setting/setting/presentation/setting_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoadingDataController loadingDataController = Get.put(
    LoadingDataController(),
  );
  int _navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset:false,
            bottomNavigationBar: appNavigationBar(),
            appBar: customAppBar(
              context: context,
              isMobile:DeviceUtils.isMobile(context) ,
              onDarkModeChanged: () {
              },
            ),
            backgroundColor:
                Get.find<ThemeController>().isDarkMode.value  ? AppColor. darkModeBackgroundColor : Color(0xFFDDDDDD),
            body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Get.find<ThemeController>().isDarkMode.value  ? AppColor.darkModeBackgroundColor : null,
                gradient:
                    Get.find<ThemeController>().isDarkMode.value 
                        ? null
                        : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [const Color(0xFFF0F9FF), Colors.white],
                        ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: context.setHeight(10),
                    right: context.setWidth(-170),
                    child: SvgPicture.asset(
                      AppImages.imageBackground,
                      package: 'shared_widgets',
                    ),
                  ),
                  if(!DeviceUtils.isMobile(context))...[
                  Positioned(
                    top: context.setHeight(0),
                    right: SharedPr.lang == "ar" ? context.setWidth(5) : null,
                    left: SharedPr.lang == "ar" ? null : context.setWidth(5),
                    bottom: context.setHeight(0),
                    child: GetBuilder<LoadingDataController>(
                        id: "loading",
                        builder: (loadingcontext) {
                          return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.setHeight(14),
                            horizontal: context.setWidth(10),
                          ),
                          child: Container(
                            width: context.setWidth(84),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color:
                                  Get.find<ThemeController>().isDarkMode.value 
                                      ? null
                                      : Colors.white.withValues(alpha: 0.70),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: Get.find<ThemeController>().isDarkMode.value  ? 0.60 : 1,
                                  color:
                                      Get.find<ThemeController>().isDarkMode.value 
                                          ? AppColor.darkModeBackgroundColor
                                          : Colors.white.withValues(alpha: 0.50),
                                ),
                                borderRadius: BorderRadius.circular(
                                  context.setMinSize(16),
                                ),
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BottomNavigationBar(
                                        name: "home",
                                        image: AppImages.home,
                                        onTap: () {
                                          _navIndex = 0;
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 0,
                                      ),
                                      BottomNavigationBar(
                                        name: "dashboard",
                                        image:AppImages.frame1,
                                        onTap: () {
                                          _navIndex = 1;
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 1,
                                      ),
                                      BottomNavigationBar(
                                        name: "products",
                                        image:AppImages.productList,
                                        onTap: () {
                                          _navIndex = 2;
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 2,
                                      ),
                                      BottomNavigationBar(
                                        name: "customers",
                                        image: AppImages.customers,
                                        onTap: () {
                                          _navIndex = 3;
                                          // setState(() {});
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 3,
                                      ),
                                      BottomNavigationBar(
                                        name: "Reports",
                                        image:AppImages.reports,
                                        onTap: () {
                                          _navIndex = 4;
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 4,
                                      ),
                                      BottomNavigationBar(
                                        name: "Settings",
                                        image:AppImages.setting,
                                        onTap: () {
                                          _navIndex = 5;
                                          // setState(() {});
                                          loadingDataController.update(["loading"]);
                                        },
                                        isSelect: _navIndex == 5,
                                      ),
                                      
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  ],
                  Positioned.fill(
                    right: SharedPr.lang == "ar" ? context.setWidth(95) : 0.0,
                    left: SharedPr.lang == "ar" ? 0.0 : context.setWidth(95),
                    top: 0,
                    child: GetBuilder<LoadingDataController>(
                      id: "loading",
                      builder: (loadingcontext) {
                        return loadingDataController.isLoad.value
                            ? const ProgressWidget()
                            : getHomeMenu(_navIndex);
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

Builder appNavigationBar() {
  return Builder(
    builder: (context) {
      return SizeProvider(
          baseSize: Size(context.screenWidth, context.setHeight(80)),
          height: context.screenHeight,
          width: context.screenWidth,
        child: NavigationBar(
            height: context.setHeight(80),
            elevation: 0,
            backgroundColor: AppColor.white,
            indicatorColor: AppColor.appColor.withAlpha(20),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
                return TextStyle(
                  fontSize: context.setSp(12),
                  color: AppColor.appColor,
                  fontFamily: 'SansMedium',
                  fontWeight: FontWeight.w400,
                );
              },
            ),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _navIndex,
            onDestinationSelected: (value) {
              _navIndex = value;
              loadingDataController.update(["loading"]);
            },
            destinations: List.generate(
              appNavigationBarItems.length,
              (int index) => NavigationDestination(
                icon: SvgPicture.asset(
                  appNavigationBarItems[index]["image"]!,
                  package: 'shared_widgets',
                  color: appNavigationBarItems[index]["name"] == "logout" ?const Color(0xFFF20C10): _navIndex == index
                        ? Get.find<ThemeController>().isDarkMode.value 
                            ? const Color(0x1916A6B7)
                            : const Color(0xFFD5F1F5)
                        : null,
                  width:context.setWidth(24),
                  height: context.setHeight(24),
                ),
                label: appNavigationBarItems[index]["name"]!.tr,
                tooltip: appNavigationBarItems[index]["name"]!.tr,
              ),
            )),
      );
    }
  );

}

}

class BottomNavigationBar extends StatelessWidget {
  String image;
  void Function()? onTap;
  bool isSelect;
  String name;
  BottomNavigationBar({
    super.key,
    required this.image,
    required this.onTap,
    this.isSelect = false,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setWidth(11),
              vertical: context.setHeight(8),
            ),
            child: Container(
              width: double.infinity,
              height: context.setHeight(50),
              decoration: ShapeDecoration(
                color:
                    isSelect
                        ? Get.find<ThemeController>().isDarkMode.value 
                            ? const Color(0x1916A6B7)
                            : const Color(0xFFD5F1F5)
                        : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.setMinSize(12)),
                ),
              ),
              child:
                  name == "logout"
                      ? Center(
                        child: SvgPicture.asset(
                          AppImages.loginIcon,
                          package: 'shared_widgets',
                          width: context.setWidth(30),
                          height: context.setHeight(30),
                          color: const Color(0xFFF20C10),
                        ),
                      )
                      : Padding(
                        padding: EdgeInsets.all(name == "create_invoice" ||  name == "home" ? context.setMinSize(10) : 0),
                        child: SvgPicture.asset(
                          image,
                          package: 'shared_widgets',
                          width: context.setWidth(53),
                          height: context.setHeight(53),
                          color:
                              isSelect
                                  ? const Color(0xFF16A6B7)
                                  : Get.find<ThemeController>().isDarkMode.value 
                                  ? Colors.white
                                  : const Color(0xFF362C2C),
                        ),
                      ),
            ),
          ),
          Text(
            name.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  isSelect
                      ? const Color(0xFF16A6B7)
                      : Get.find<ThemeController>().isDarkMode.value 
                      ? Colors.white
                      : const Color(0xFF362C2C),
              fontSize: context.setSp(12),
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w800,
              height: 1.40,
            ),
          ),
          SizedBox(height: context.setHeight(5)),
        ],
      ),
    );
  }
}

Widget getHomeMenu(int index) {
  switch (index) {
    case 0:
      return Dashboard();
    case 1:
      return Container();
    case 2:
      return ProductScreen();
    case 3:
      return CustomerScreen();
    case 4:
      return ReportSession();
    case 5:
      return SettingScreen();
    default:
      return Container();
  }
}

var appNavigationBarItems=[
{
  "name":"home",
  "image":AppImages.home,
},
{
  "name":"dashboard",
  "image":AppImages.frame1,
},
{
  "name":"products",
  "image":AppImages.productList,
},
{
  "name":"customers",
  "image":AppImages.customers,
},
{
  "name":"Reports",
  "image":AppImages.reports,
},
{
  "name":"Settings",
  "image":AppImages.setting,
}
];
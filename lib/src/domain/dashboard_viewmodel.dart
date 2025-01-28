import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yousentech_pos_dashboard/config/app_enums.dart';
import '../presentation/views/user_dashboard_screen.dart';
import 'dashboard_service.dart';

class DashboardController extends GetxController {
  bool isSidebarOpen = false;
  late AnimationController animationController;
  SideUserMenu selectedMenu = SideUserMenu.dashboard;
  SideUserMenu? preselectedMenu;
  Widget content = const UserDashboard();
  SideUserMenu? sufelectedMenu = SideUserMenu
      .values[SideUserMenu.values.indexOf(SideUserMenu.dashboard) + 1];
  int? selectedSubMenu;
  int selectedMenulength = 0;
  static DashboardController? _instance;
  var isLoading = false.obs;
  late DashboardService dashboardService;

  DashboardController._() {
    dashboardService = DashboardService();
  }

  static DashboardController getInstance() {
    _instance ??= DashboardController._();
    return _instance!;
  }

  // void toggleSidebar() {
  //   isSidebarOpen = !isSidebarOpen;
  //   if (isSidebarOpen) {
  //     if (sideUserMenu[selectedMenu]!.isNotEmpty) {
  //       animationController.forward();
  //     } else {
  //       isSidebarOpen = !isSidebarOpen;
  //     }
  //   } else {
  //     selectedMenu = SideUserMenu.dashboard;
  //     animationController.reverse();
  //   }
  //   update(['sideUserMenu']);
  // }
  Future resetselctedmenu() async {
    selectedMenu = SideUserMenu.dashboard;
    preselectedMenu = null;
    sufelectedMenu = SideUserMenu
        .values[SideUserMenu.values.indexOf(SideUserMenu.dashboard) + 1];
  }

  Future updateSelectedMenu(
      {required SideUserMenu sideUserMenu,
      bool issubmenu = false,
      int? subMenu}) async {
    if (sideUserMenu != selectedMenu) {
      selectedMenu = sideUserMenu;
    }
    int indexselected = SideUserMenu.values.indexOf(sideUserMenu);
    if (indexselected - 1 != -1) {
      preselectedMenu = SideUserMenu.values[indexselected - 1];
    } else {
      preselectedMenu = null;
    }
    if (indexselected + 1 != SideUserMenu.values.length) {
      sufelectedMenu = SideUserMenu.values[indexselected + 1];
    } else {
      sufelectedMenu = null;
    }
    // print("$selectedMenu $preselectedMenu  $sufelectedMenu");
  }
}

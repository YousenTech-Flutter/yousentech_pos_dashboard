import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';

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

  // ===================================================== [ RESET SELECTED MENU ] =====================================================
  // Functionality:
  // - Resets the current selected menu to the dashboard
  // - Updates the `selectedMenu`, `preselectedMenu`, and `sufelectedMenu` values accordingly
  // Input:
  // - None explicitly
  // Raises:
  // - None explicitly
  // Returns:
  // - None explicitly (modifies the `selectedMenu`, `preselectedMenu`, and `sufelectedMenu` values)
  // ====================================================================================================================================

  Future resetselctedmenu() async {
    selectedMenu = SideUserMenu.dashboard;
    preselectedMenu = null;
    sufelectedMenu = SideUserMenu
        .values[SideUserMenu.values.indexOf(SideUserMenu.dashboard) + 1];
  }
  // ===================================================== [ RESET SELECTED MENU ] =====================================================
  // ===================================================== [ UPDATE SELECTED MENU ] =====================================================
  // Functionality:
  // - Updates the currently selected menu, as well as the previous and next menu items
  // - Updates the `selectedMenu`, `preselectedMenu`, and `sufelectedMenu` based on the selected `sideUserMenu`
  // Input:
  // - `sideUserMenu`: The menu item to be selected
  // - `issubmenu`: Optional flag to check if it's a submenu (default: false)
  // - `subMenu`: Optional submenu index (if relevant)
  // Raises:
  // - None explicitly
  // Returns:
  // - None explicitly (modifies the `selectedMenu`, `preselectedMenu`, and `sufelectedMenu` values)
  // ====================================================================================================================================

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
  // ===================================================== [ UPDATE SELECTED MENU ] =====================================================
}

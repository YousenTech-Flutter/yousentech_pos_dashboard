import 'package:flutter/material.dart';
import 'package:yousentech_pos_basic_data_management/yousentech_pos_basic_data_management.dart';
import 'package:yousentech_pos_dashboard/config/app_enums.dart';

var sideUserMenu = {
  SideUserMenu.dashboard: [],
  SideUserMenu.pointOfSale: [],
  SideUserMenu.orders: [],
  SideUserMenu.products: [],
  SideUserMenu.customers: [],
  SideUserMenu.categories: [],
  SideUserMenu.units: [],
  SideUserMenu.accountTax: [],
  SideUserMenu.accountJournal: [],
  SideUserMenu.reports: [
    // [
    //   "orders",
    //   [Icons.add_shopping_cart_rounded, Container()]
    // ],
    // [
    //   "sale_details",
    //   [Icons.details, Container()]
    // ],
    // [
    //   "session_report",
    //   [Icons.report, Container()]
    // ]
  ],
  SideUserMenu.configuration: [],
  SideUserMenu.databaseInfoSetting: [],
  SideUserMenu.dataManagement: [
    [
      "products",
      ["product", const ProductListScreen()]
    ],
    [
      "categories",
      [Icons.category, const PosCategoryListScreen()]
    ],
    [
      "customers",
      [Icons.people_alt, const CustomersListScreen()]
    ],
    [
      "units",
      [Icons.people_alt, const PosProductUnitListScreen()]
    ],
    [
      "pos_account_tax_list",
      [Icons.people_alt, const PosAccountTaxListScreen()]
    ],
    [
      "pos_account_journal_list",
      [Icons.payment, const PosAccountJournalListScreen()]
    ]
  ]
};
List<String> dashBoardFilter = [
  'today',
  'month',
  'week',
  'current_quarter',
  'current_year',
  'last_day',
  'last_month',
  'last_week',
  'last_quarter',
  'last_year'
];

import 'package:flutter/material.dart';
import 'package:yousentech_pos_dashboard/dashboard/config/app_enums.dart';

// var sideUserMenu = {
//   SideUserMenu.dashboard: [],
//   SideUserMenu.pointOfSale: [],
//   SideUserMenu.orders: [],
//   SideUserMenu.products: [],
//   SideUserMenu.customers: [],
//   SideUserMenu.categories: [],
//   SideUserMenu.units: [],
//   SideUserMenu.accountTax: [],
//   SideUserMenu.accountJournal: [],
//   SideUserMenu.reports: [
//   ],
//   SideUserMenu.configuration: [],
//   SideUserMenu.databaseInfoSetting: [],
//   SideUserMenu.dataManagement: [
//     [
//       "products",
//       ["product", const ProductListScreen()]
//     ],
//     [
//       "categories",
//       [Icons.category, const PosCategoryListScreen()]
//     ],
//     [
//       "customers",
//       [Icons.people_alt, const CustomersListScreen()]
//     ],
//     [
//       "units",
//       [Icons.people_alt, const PosProductUnitListScreen()]
//     ],
//     [
//       "pos_account_tax_list",
//       [Icons.people_alt, const PosAccountTaxListScreen()]
//     ],
//     [
//       "pos_account_journal_list",
//       [Icons.payment, const PosAccountJournalListScreen()]
//     ]
//   ],
//   SideUserMenu.invoiceReturn: [],
// };
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

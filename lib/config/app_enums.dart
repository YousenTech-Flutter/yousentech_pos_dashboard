import 'dart:ui';

enum SideUserMenu {
  dashboard,
  pointOfSale,
  orders,
  products,
  customers,
  units,
  reports,
  configuration,
  categories,
  accountTax,
  accountJournal,
  databaseInfoSetting,
  dataManagement
}

enum InfoTotalCard {
  netIncome('netSales', 'assets/image/net_income.svg', 0, Color(0xffF2AC57)),
  totalSales(
      'total_sales', 'assets/image/total_sales.svg', 0, Color(0xff16A6B7)),
  totalReturns(
      'total_returns', 'assets/image/total_returns.svg', 0, Color(0xffFF9A7A));

  final String text;
  // final double price;
  final double percentage;
  final String icon;
  final Color color;

  const InfoTotalCard(this.text, this.icon, this.percentage, this.color);
}

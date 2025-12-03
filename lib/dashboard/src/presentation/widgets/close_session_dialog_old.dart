// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_widgets/config/app_colors.dart';
// import 'package:shared_widgets/config/app_styles.dart';
// import 'package:shared_widgets/shared_widgets/app_button.dart';
// import 'package:shared_widgets/shared_widgets/app_dialog.dart';
// import 'package:yousentech_pos_session/pos_session/src/domain/session_viewmodel.dart';
// import 'package:yousentech_pos_session/pos_session/src/utils/show_pending_deletion_confirm_dialog.dart';
// void closeSessionDialog({
//   required onPressed,
//   double? openAmount,
//   double? closingAmount,
//   double? salesAmount,
//   int? submittedInvoicesNo,
// }) {
//   CustomDialog.getInstance().itemDialog(
//     title: "closeSession".tr,
//     barrierDismissible: true,
//     content: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           GetBuilder<SessionController>(builder: (controller) {
//             return Row(
//               children: [
//                 SessionItemRow(
//                     titel: "pending_invoices_number".tr,
//                     text: controller.pendingInvoiceNo.toString()),
//                 if (controller.pendingInvoiceNo != 0) ...[
//                   IconButton(
//                       onPressed: () {
//                         showPendingInvoiceDeletionConfirmDialog(
//                             sessionController: controller);
//                       },
//                       icon: const Icon(Icons.delete_forever_rounded))
//                 ]
//               ],
//             );
//           }),
//           SizedBox(
//             height: Get.height * 0.01,
//           ),
//           SessionItemRow(
//               titel: "submitting_invoices_number".tr,
//               text: submittedInvoicesNo.toString()),
//           SizedBox(
//             height: Get.height * 0.01,
//           ),
//           SessionItemRow(
//               titel: "openingBalanceSession".tr, text: openAmount.toString()),
//           SizedBox(
//             height: Get.height * 0.01,
//           ),
//           SessionItemRow(
//               titel: "closingAmount".tr, text: closingAmount.toString()),
//           SizedBox(
//             height: Get.height * 0.01,
//           ),
//           SessionItemRow(titel: "salesAmount".tr, text: salesAmount.toString()),
//           SizedBox(
//             height: Get.height * 0.04,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ButtonElevated(
//                   text: 'closeSession'.tr,
//                   width: Get.width / 8,
//                   borderColor: AppColor.shadepurple,
//                   textStyle: AppStyle.textStyle(
//                       color: AppColor.shadepurple,
//                       fontSize: 20,
//                       fontWeight: FontWeight.normal),
//                   onPressed: onPressed),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// class SessionItemRow extends StatelessWidget {
//   const SessionItemRow({
//     super.key,
//     this.titel,
//     this.text,
//   });

//   final String? titel;
//   final String? text;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             titel ?? '',
//             style: AppStyle.textStyle(
//               color: AppColor.grey,
//               fontSize: MediaQuery.of(context).size.height * 0.013,
//             ),
//           ),
//         ),
//         Text(text ?? '',
//             style: AppStyle.textStyle(
//               fontSize: MediaQuery.of(context).size.height * 0.013,
//             ))
//       ],
//     );
//   }
// }

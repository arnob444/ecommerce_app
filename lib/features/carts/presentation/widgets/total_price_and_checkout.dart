// ignore_for_file: deprecated_member_use
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/utils/constants.dart';
import 'package:ecommerce/features/carts/presentation/controllers/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class TotalPriceAndCheckout extends StatelessWidget {
  const TotalPriceAndCheckout({super.key});

  Future<void> payment(double amount) async {
    try {
      Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          ipn_url: "www.sikhtechi.com",
          multi_card_name: "visa,master,bkash",
          currency: SSLCurrencyType.BDT,
          product_category: "E-commerce",
          sdkType: SSLCSdkType.TESTBOX,
          store_id: "sikht68f1037d40631",
          store_passwd: "sikht68f1037d40631@ssl",
          total_amount: amount,
          tran_id: "tran_${DateTime.now().millisecondsSinceEpoch}",
        ),
      );

      SSLCTransactionInfoModel response = await sslcommerz.payNow();

      if (response.status == "VALID") {
        print('Payment Successful');
        print('TxID: ${response.tranId}');
        print('Date: ${response.tranDate}');
        Get.snackbar(
          'Payment Successful',
          'Transaction ID: ${response.tranId}',
          backgroundColor: Colors.green.withOpacity(0.2),
        );
      } else if (response.status == "FAILED") {
        print('Payment Failed');
        Get.snackbar(
          'Payment Failed',
          'Please try again',
          backgroundColor: Colors.red.withOpacity(0.2),
        );
      } else if (response.status == "Closed") {
        print('Payment Closed');
        Get.snackbar(
          'Payment Closed',
          'Transaction was closed by user',
          backgroundColor: Colors.orange.withOpacity(0.2),
        );
      }
    } catch (e) {
      print('SSLCommerz Error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red.withOpacity(0.2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GetBuilder<CartListController>(
                builder: (controller) {
                  return Text(
                    '$takaSign${controller.totalPrice}',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: GetBuilder<CartListController>(
              builder: (controller) {
                return FilledButton(
                  onPressed: () {
                    payment(controller.totalPrice.toDouble());
                  },
                  child: Text("Checkout"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

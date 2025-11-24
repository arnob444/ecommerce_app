import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class LearnNewScreen extends StatefulWidget {
  const LearnNewScreen({super.key});

  @override
  State<LearnNewScreen> createState() => _LearnNewScreenState();
}

class _LearnNewScreenState extends State<LearnNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          payment();
        },
        child: Text('Press here'),
      ),
    );
  }
}

Future<void> payment() async {
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      ipn_url: "www.sikhtechi.com",
      multi_card_name: "visa,master,bkash",
      currency: SSLCurrencyType.BDT,
      product_category: "Food",
      sdkType: SSLCSdkType.TESTBOX,
      store_id: "sikht68f1037d40631",
      store_passwd: "sikht68f1037d40631@ssl",
      total_amount: 1.0,
      tran_id: "custom_transaction_id",
    ),
  );

  final response = await sslcommerz.payNow();
  if (response.status == "VALID") {
    print('success');
    print('TxID: ${response.tranId}');
    print('Date: ${response.tranDate}');
  }
  if (response.status == "Closed") {}
  if (response.status == "FAILED") {}
}

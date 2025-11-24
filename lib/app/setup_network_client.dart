import 'package:ecommerce/app/app.dart';
import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/core/services/network_caller.dart';
import 'package:ecommerce/features/auth/presentation/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorize: _onUnAuthorize,
    accessToken: () {
      return Get.find<AuthController>().accessToken ?? '';
    },
  );
}

Future<void> _onUnAuthorize() async {
  // TODO: remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SigninScreen.name,
    (predicate) => false,
  );
}
  
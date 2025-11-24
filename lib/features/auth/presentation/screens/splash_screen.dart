import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/app/extensions/localization_extention.dart';
import 'package:ecommerce/app/utils/app_version_service.dart';
import 'package:ecommerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../shared/presentation/screens/botton_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 7));
    if (!mounted) return;

    bool isUserLoggedIn = await Get.find<AuthController>().isUserAlreadyLoggedIn();
    if (!mounted) return;
    
    if (isUserLoggedIn) {
      await Get.find<AuthController>().loadFutureData();
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, BottonNavScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                '${context.localization.version} ${AppVersionService.currentAppVersion}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Text(context.localization.hello),
// LanguageChangeSwitch(),
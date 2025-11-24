import 'package:ecommerce/features/auth/presentation/screens/signin_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/verify_Otp_screen.dart';
import 'package:ecommerce/features/product/presentation/screen/product_details_screen.dart';
import 'package:ecommerce/features/product/presentation/screen/product_list_screen.dart';
import 'package:ecommerce/features/shared/presentation/models/category_model.dart';
import 'package:ecommerce/features/shared/presentation/screens/botton_nav_screen.dart';
import 'package:flutter/material.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;
  if (settings.name == SplashScreen.name) {
    screen = SplashScreen();
  } else if (settings.name == SigninScreen.name) {
    screen = SigninScreen();
  } else if (settings.name == SignupScreen.name) {
    screen = SignupScreen();
  } else if (settings.name == VerifyOtpScreen.name) {
    final String email = settings.arguments as String;
    screen = VerifyOtpScreen(email: email);
  } else if (settings.name == BottonNavScreen.name) {
    screen = BottonNavScreen();
  } else if (settings.name == ProductListScreen.name) {
    final CategoryModel category = settings.arguments as CategoryModel;
    screen = ProductListScreen(category: category);
  } else if (settings.name == ProductDetailsScreen.name) {
    final String productId = settings.arguments as String;
    screen = ProductDetailsScreen(productId: productId);
  }

  return MaterialPageRoute(builder: (context) => screen);
}

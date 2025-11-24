import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/app/extensions/localization_extention.dart';
import 'package:ecommerce/features/auth/presentation/controller/log_in_controller.dart';
import 'package:ecommerce/features/auth/presentation/models/log_in_request_model.dart';
import 'package:ecommerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecommerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/presentation/screens/botton_nav_screen.dart';
import '../../../shared/presentation/widgets/snackbar_msg.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LogInController _logInController = Get.find<LogInController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                AppLogo(width: 100),
                SizedBox(height: 8),
                Text(
                  context.localization.welcomeBack,
                  style: textTheme.titleLarge,
                ),
                Text(
                  context.localization.loginHeadline,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 16),
                GetBuilder<LogInController>(
                  builder: (context) {
                    return Visibility(
                      visible: _logInController.loginInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: _onTapLoginButton,
                        child: Text("Login"),
                      ),
                    );
                  }
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: _onTapSignUpButton,
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    // form validation
    _signIn();
  }

  Future<void> _signIn() async {
    LogInRequestModel model = LogInRequestModel(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    bool isSuccess = await _logInController.logIn(model);
    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
        _logInController.userModel!,
        _logInController.accessToken!,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottonNavScreen.name,
        (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, _logInController.errorMessage!);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignupScreen.name);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

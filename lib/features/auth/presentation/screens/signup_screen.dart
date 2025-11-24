import 'package:ecommerce/features/auth/presentation/controller/sign_up_controller.dart';
import 'package:ecommerce/features/auth/presentation/models/sign_up_request_model.dart';
import 'package:ecommerce/features/auth/presentation/screens/signin_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/verify_Otp_screen.dart';
import 'package:ecommerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce/features/shared/presentation/widgets/snackbar_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignUpController _signUpController = Get.find<SignUpController>();

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
                SizedBox(height: 24),
                AppLogo(width: 80),
                SizedBox(height: 12),
                Text('Create new account', style: textTheme.titleLarge),
                Text(
                  'Please enter your details for new account',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'First name'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Last name'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _mobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Mobile'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _addressController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Adrress'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 16),
                GetBuilder<SignUpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.signUpInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: _onTapSignUpButton,
                        child: Text("Sign up"),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: _onTapLoginButton,
                  child: Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    Navigator.pushNamed(context, SigninScreen.name);
  }

  void _onTapSignUpButton() {
    //TODO : Validate Form
    _signUp();
  }

  Future<void> _signUp() async {
    SignUpRequestModel model = SignUpRequestModel(
      firstname: _firstNameController.text.trim(),
      lastname: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      city: _addressController.text.trim(),
      phone: _mobileController.text.trim(),
    );

    final bool isSuccess = await _signUpController.signUp(model);
    if (isSuccess) {
      showSnackBarMessage(context, 'Sign up successfull! Please login');
      Navigator.pushNamed(
        context,
        VerifyOtpScreen.name,
        arguments: _emailController.text.trim(),
      );
    } else {
      showSnackBarMessage(context, _signUpController.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/presentation/controller/otp_controller.dart';
import 'package:ecommerce/features/auth/presentation/models/verify_otp_req_model.dart';
import 'package:ecommerce/features/auth/presentation/screens/signin_screen.dart';
import 'package:ecommerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce/features/shared/presentation/screens/botton_nav_screen.dart';
import 'package:ecommerce/features/shared/presentation/widgets/snackbar_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});
  static const String name = '/verify-otp';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final VerifyOtpController _verifyOtpController = Get.find<VerifyOtpController>();

  Timer? _timer;
  int _remainingSeconds = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

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
                const SizedBox(height: 24),
                AppLogo(width: 80),
                const SizedBox(height: 12),
                Text('Verify OTP', style: textTheme.titleLarge),
                Text(
                  'A 6 digit otp has been sent to your email address',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  appContext: context,
                  controller: _otpController,
                ),
                const SizedBox(height: 16),
                GetBuilder<VerifyOtpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.verifyOtpInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: _onTapVerifyButton,
                        child: const Text("Verify"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Countdown Timer
                Text(
                  _remainingSeconds > 0
                      ? "This code will expire in ${_remainingSeconds}s"
                      : "Code expired",
                  style: textTheme.bodySmall?.copyWith(
                    color: _remainingSeconds > 0 ? Colors.grey : Colors.red,
                  ),
                ),

                const SizedBox(height: 8),
                TextButton(
                  onPressed: _remainingSeconds == 0 ? _onTapResendCode : null,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: _remainingSeconds == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: _onTapBackToLoginButton,
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapVerifyButton() {
    _verifyOtp();
  }

  Future<void> _verifyOtp() async {
    VerifyOtpReqModel model = VerifyOtpReqModel(
      email: widget.email,
      otp: _otpController.text,
    );
    final bool isSuccess = await _verifyOtpController.verifyOtp(model);

    if (isSuccess) {
      // cache user data
      await Get.find<AuthController>().saveUserData(
        _verifyOtpController.userModel!,
        _verifyOtpController.accessToken!,
      );
      Navigator.pushNamedAndRemoveUntil(context,BottonNavScreen.name,(predicate) => false);
    } else {
      showSnackBarMessage(context, _verifyOtpController.errorMessage!);
    }
  }

  void _onTapResendCode() {
    _startTimer();
    // TODO: Resend OTP API Call
  }

  void _onTapBackToLoginButton() {
    Navigator.pushNamedAndRemoveUntil(context, SigninScreen.name, (p) => false);
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

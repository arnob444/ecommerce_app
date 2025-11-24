import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/core/models/network_response.dart';
import 'package:ecommerce/core/services/network_caller.dart';
import 'package:get/get.dart';
import '../models/sign_up_request_model.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpRequestModel model) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: Urls.signUpUrl, body: model.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }

    _signUpInProgress = false;
    update();
    return isSuccess;
  }
}
import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/core/models/network_response.dart';
import 'package:ecommerce/core/services/network_caller.dart';
import 'package:ecommerce/features/auth/presentation/models/log_in_request_model.dart';
import 'package:ecommerce/features/shared/presentation/models/user_model.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  bool _loginInProgress = false;
  String? _errorMessage;
  UserModel? _userModel;
  String? _accessToken;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;
  UserModel? get userModel => _userModel;
  String? get accessToken => _accessToken;

  Future<bool> logIn(LogInRequestModel model) async {
    bool isSuccess = false;
    _loginInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: Urls.logInUrl, body: model.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _userModel = UserModel.fromJson(response.body!['data']['user']);
      _accessToken = response.body!['data']['token'];
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }

    _loginInProgress = false;
    update();
    return isSuccess;
  }
}
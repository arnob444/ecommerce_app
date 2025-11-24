import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/app/setup_network_client.dart';
import 'package:ecommerce/features/auth/presentation/controller/log_in_controller.dart';
import 'package:ecommerce/features/auth/presentation/controller/otp_controller.dart';
import 'package:ecommerce/features/auth/presentation/controller/sign_up_controller.dart';
import 'package:ecommerce/features/carts/presentation/controllers/cart_list_controller.dart';
import 'package:ecommerce/features/home/presentation/controllers/home_slides_controllers.dart';
import 'package:ecommerce/features/product/presentation/controllers/product_list_controller.dart';
import 'package:ecommerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:ecommerce/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:ecommerce/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(LogInController());
    Get.put(HomeSlidesControllers());
    Get.put(CategoryController());
    Get.put(CartListController());
    Get.put(WishlistController());
    Get.put(ProductListController());
  }
}

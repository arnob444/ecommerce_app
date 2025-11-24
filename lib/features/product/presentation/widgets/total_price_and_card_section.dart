// ignore_for_file: deprecated_member_use
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/controllers/auth_controller.dart';
import 'package:ecommerce/app/utils/constants.dart';
import 'package:ecommerce/features/auth/presentation/screens/signin_screen.dart';
import 'package:ecommerce/features/product/presentation/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/features/shared/presentation/widgets/snackbar_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class totalPriceAndCartSection extends StatefulWidget {
  const totalPriceAndCartSection({super.key, required this.productId});

  final String productId;

  @override
  State<totalPriceAndCartSection> createState() =>
      _totalPriceAndCartSectionState();
}

class _totalPriceAndCartSectionState extends State<totalPriceAndCartSection> {
  final AddToCartController _addToCartController = AddToCartController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${takaSign}120',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          GetBuilder(
            init: _addToCartController,
            builder: (controller) {
              return SizedBox(
                width: 120,
                child: Visibility(
                  visible: controller.addToCartInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                    onPressed: _onTapAddToCardButton,
                    child: Text("Add to Cart"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCardButton() async {
    if (await Get.find<AuthController>().isUserAlreadyLoggedIn()) {
      // TODO: Add to cart
      final bool isSuccess = await _addToCartController.addToCart(
        widget.productId,
      );
      if (isSuccess) {
        showSnackBarMessage(context, "Added to cart");
      } else {
        showSnackBarMessage(context, _addToCartController.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, SigninScreen.name);
    }
  }
}

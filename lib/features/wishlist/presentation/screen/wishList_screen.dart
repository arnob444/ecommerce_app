// import 'package:ecommerce/features/shared/presentation/models/product_model.dart';
import 'package:ecommerce/features/shared/presentation/widgets/product_card.dart';
import 'package:ecommerce/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController _wishlistController = Get.find<WishlistController>();

  @override
  void initState() {
    super.initState();
    // Optional: Load from storage or API if you plan to persist wishlist
    // _wishlistController.loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: GetBuilder<WishlistController>(
        init: _wishlistController,
        builder: (controller) {
          if (controller.wishlistProducts.isEmpty) {
            return const Center(
              child: Text(
                'Your wishlist is empty',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: controller.wishlistProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.wishlistProducts[index];
                    return FittedBox(
                      child: ProductCard(productModel: product),
                    );
                  },
                ),
              ),
              Visibility(
                visible: controller.wishlistUpdating,
                child: const LinearProgressIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }
}

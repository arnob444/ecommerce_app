// ignore_for_file: deprecated_member_use
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/presentation/controllers/product_details_controller.dart';
import 'package:ecommerce/features/product/presentation/widgets/color_picker.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_image_slider.dart';
import 'package:ecommerce/features/product/presentation/widgets/size_picker.dart';
import 'package:ecommerce/features/product/presentation/widgets/total_price_and_card_section.dart';
import 'package:ecommerce/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/presentation/models/product_model.dart';
import '../../../wishlist/presentation/controllers/wishlist_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController = ProductDetailsController();
  final WishlistController wishlistController = Get.find<WishlistController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsController.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.getProductDetailsInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(
                        imageUrls: controller.productDetailsModel?.photos ?? [],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          // spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.productDetailsModel?.title ?? '',
                                        style: textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Wrap(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 24,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                controller.productDetailsModel?.rating ?? '',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text("Reviews"),
                                          ),
                                          GetBuilder(
                                            init: wishlistController,
                                              builder: (wishlistController) {
                                                final isInWishlist = wishlistController.isInWishlist(
                                                  controller.productDetailsModel?.id ?? '',
                                                );
                                                return InkWell(
                                                  onTap: () {
                                                    final productDetails = controller.productDetailsModel;
                                                          if (productDetails != null) {
                                                            final product = ProductModel(
                                                              id: productDetails.id,
                                                              title: productDetails.title,
                                                              photos: productDetails.photos,
                                                              currentPrice: productDetails.currentPrice,
                                                              rating: double.tryParse(productDetails.rating.toString()) ?? 0.0,
                                                            );
                                                       wishlistController.toggleWishlist(product);
                                                    }
                                                  },
                                                  child: Card(
                                                    color: AppColors.themeColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Icon(
                                                        isInWishlist ? Icons.favorite : Icons.favorite_border_outlined,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  child: IncDecButton(onChange: (int value) {}),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Visibility(
                              visible: (controller.productDetailsModel?.colors ?? []).isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text('Color', style: TextStyle(fontSize: 18)),
                              )),
                              const SizedBox(height: 8,),
                            ColorPicker(
                              colors: controller.productDetailsModel?.colors ?? [],
                              onSelected: (String color) {},
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: (controller.productDetailsModel?.sizes ?? []).isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text('Size', style: TextStyle(fontSize: 18)),
                              )),
                              const SizedBox(height: 16),
                            SizePicker(
                              sizes: controller.productDetailsModel?.sizes ?? [],
                              onSelected: (String size) {},
                            ),
                            const SizedBox(height: 8),
                            Text('Description', style: TextStyle(fontSize: 18)),
                            Text(
                              controller.productDetailsModel?.description ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              totalPriceAndCartSection(productId: widget.productId),
            ],
          );
        },
      ),
    );
  }
}

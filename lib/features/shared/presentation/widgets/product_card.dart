import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/utils/constants.dart';
import 'package:ecommerce/features/product/presentation/screen/product_details_screen.dart';
import 'package:ecommerce/features/shared/presentation/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../wishlist/presentation/controllers/wishlist_controller.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find<WishlistController>();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        shadowColor: AppColors.themeColor.withOpacity(.3),
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Image.network(
                  // AssetPaths.dummyImageSvg,
                  productModel.photos.firstOrNull ?? '',
                  width: 130,
                  height: 80,
                  errorBuilder: (_, __, ___) {
                    return SizedBox(
                      width: 130,
                      height: 80,
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Nike Airforce',
                      productModel.title,
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$takaSign${productModel.currentPrice}',
                          // '${takaSign}120',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text(productModel.rating.toString()),
                          ],
                        ),
                        // Card(
                        //   color: AppColors.themeColor,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadiusGeometry.circular(4),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(2.0),
                        //     child: Icon(
                        //       Icons.favorite_border_outlined,
                        //       size: 15,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        GetBuilder<WishlistController>(
                          init: wishlistController,
                          builder: (wishlistController) {
                            final isInWishlist = wishlistController.isInWishlist(productModel.id);
                            return InkWell(
                              onTap: () {
                                wishlistController.toggleWishlist(productModel);
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
            ],
          ),
        ),
      ),
    );
  }
}

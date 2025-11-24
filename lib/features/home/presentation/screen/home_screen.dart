// ignore_for_file: deprecated_member_use
import 'package:ecommerce/app/asset_paths.dart';
import 'package:ecommerce/features/home/presentation/controllers/home_slides_controllers.dart';
import 'package:ecommerce/features/home/presentation/widgets/appIconButton.dart';
import 'package:ecommerce/features/home/presentation/widgets/home_banner_slider.dart';
import 'package:ecommerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:ecommerce/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:ecommerce/features/shared/presentation/widgets/product_card.dart';
import 'package:ecommerce/features/shared/presentation/widgets/product_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../product/presentation/controllers/product_list_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductListController _productListController = Get.find<ProductListController>(); // newly added

  @override // newly added
  void initState() {
    super.initState();
    _productListController.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(AssetPaths.logoNavSvg),
        actions: [
          appBarIconButton(onTap: () {}, iconData: Icons.person),
          appBarIconButton(onTap: () {}, iconData: Icons.call),
          appBarIconButton(
            onTap: () {},
            iconData: Icons.notification_important,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              buildSearchBar(),
              const SizedBox(height: 16),
              GetBuilder<HomeSlidesControllers>(
                builder: (controller) {
                  if (controller.getSlidersInProgress) {
                    return SizedBox(
                      height: 180,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return HomeBannerSlider(sliders: controller.sliders);
                },
              ),
              buildSectionHeader(
                title: "Categories",
                onTapSeeAll: () {
                  Get.find<MainNavController>().moveToCategory();
                },
              ),
              _buildCategoryList(),
              buildSectionHeader(title: "New", onTapSeeAll: () {}), 
              GetBuilder<ProductListController>( // new
                init: _productListController,
                builder: (controller) {
                  return buildNewProductList(controller);
                },
              ),

              buildSectionHeader(title: "Popular", onTapSeeAll: () {}),
              GetBuilder<ProductListController>( // new
                init: _productListController,
                builder: (controller) {
                  return buildPopularProductList(controller);
                },
              ),
              
              buildSectionHeader(title: "Special", onTapSeeAll: () {}),
              GetBuilder<ProductListController>( // new
                init: _productListController,
                builder: (controller) {
                  return buildSpecialProductList(controller);
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: GetBuilder<CategoryController>(
        builder: (controller) {
          if (controller.getCategoryInProgress) {
            //change
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: controller.categoryList.length > 10
                ? 10
                : controller.categoryList.length,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return productCategoryItem(
                categoryModel: controller.categoryList[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
          );
        },
      ),
    );
  }

  // Widget buildNewProductList() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(children: [1, 2, 3, 4, 5].map((e) => ProductCard(productModel: null,)).toList()),
  //   );
  // }

  Widget buildNewProductList(ProductListController controller) {
    // newdly added
    return SizedBox(
      height: 200,
      child: controller.getProductInProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                final product = controller.productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(productModel: product),
                );
              },
            ),
    );
  }

  Widget buildPopularProductList(ProductListController controller) {
    return SizedBox(
      height: 200,
      child: controller.getProductInProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                final product = controller.productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(productModel: product),
                );
              },
            ),
    );
  }

  Widget buildSpecialProductList(ProductListController controller) {
    return SizedBox(
      height: 200,
      child: controller.getProductInProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                final product = controller.productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(productModel: product),
                );
              },
            ),
    );
  }

  Widget buildSectionHeader({
    required String title,
    required VoidCallback onTapSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onTapSeeAll, child: Text("See all")),
      ],
    );
  }

  Widget buildSearchBar() {
    return TextField(
      onSubmitted: (String? text) {},
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
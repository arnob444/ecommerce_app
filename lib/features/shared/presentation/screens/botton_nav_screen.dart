import 'package:ecommerce/features/carts/presentation/screens/cart_screen.dart';
import 'package:ecommerce/features/category/presentation/screens/category_list_screen.dart';
import 'package:ecommerce/features/home/presentation/controllers/home_slides_controllers.dart';
import 'package:ecommerce/features/home/presentation/screen/home_screen.dart';
import 'package:ecommerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:ecommerce/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:ecommerce/features/wishlist/presentation/screen/wishList_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottonNavScreen extends StatefulWidget {
  const BottonNavScreen({super.key});

  static const String name = '/bottom-nav-holder';

  @override
  State<BottonNavScreen> createState() => _BottonNavScreenState();
}

class _BottonNavScreenState extends State<BottonNavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishlistScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeSlidesControllers>().getHomeSliders();
    Get.find<CategoryController>().getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavController>(
      builder: (mainNavController) {
        return Scaffold(
          body: _screens[mainNavController.currentIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: mainNavController.currentIndex,
            onDestinationSelected: mainNavController.changeIndex,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.category),
                label: 'Categoires',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_checkout),
                label: 'Card',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}

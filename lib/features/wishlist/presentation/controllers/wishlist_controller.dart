import 'package:get/get.dart';
import '../../../shared/presentation/models/product_model.dart';

class WishlistController extends GetxController {
  final List<ProductModel> _wishlistProducts = [];
  bool _wishlistUpdating = false;
  String? _errorMessage;

  List<ProductModel> get wishlistProducts => _wishlistProducts;
  bool get wishlistUpdating => _wishlistUpdating;
  String? get errorMessage => _errorMessage;

  void addToWishlist(ProductModel product) {
    if (!_wishlistProducts.any((p) => p.id == product.id)) {
      _wishlistProducts.add(product);
      _errorMessage = null;
      update();
      Get.snackbar('Added', '${product.title} added to wishlist');
    } else {
      Get.snackbar('Already Exists', '${product.title} is already in wishlist');
    }
  }

  void removeFromWishlist(String productId) {
    _wishlistProducts.removeWhere((p) => p.id == productId);
    _errorMessage = null;
    update();
    Get.snackbar('Removed', 'Product removed from wishlist');
  }


  void toggleWishlist(ProductModel product) {
    if (_wishlistProducts.any((p) => p.id == product.id)) {
      removeFromWishlist(product.id);
    } else {
      addToWishlist(product);
    }
  }

  void clearWishlist() {
    _wishlistProducts.clear();
    update();
  }

  bool isInWishlist(String productId) {
    return _wishlistProducts.any((p) => p.id == productId);
  }
}

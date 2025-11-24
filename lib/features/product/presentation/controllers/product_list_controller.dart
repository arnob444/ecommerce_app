import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/models/product_model.dart';

class ProductListController extends GetxController {
  int _currentPage = 0;
  int? _lastPageNo;
  final int _pageSize = 40;
  bool _getProductInProgress = false;
  bool _isInitialLoading = false;
  List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get getProductInProgress => _getProductInProgress;
  bool get isInitialLoading => _isInitialLoading;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(String categoryId) async {
    bool isSuccess = false;
    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }

    if (_currentPage == 0) {
      _productList.clear();
      _isInitialLoading = true;
    } else {
      _getProductInProgress = true;
    }
    update();
    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListUrl(_currentPage, _pageSize, categoryId),
    );

    if (response.isSuccess) {
      _lastPageNo = response.body!['data']['last_page'];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getProductInProgress = false;
    }
    update();
    return isSuccess;
  }

  Future<void> refreshProductList(String categoryId) async {
    _currentPage = 0;
    getProductListByCategory(categoryId);
  }

  Future<bool> getAllProducts() async { // newly added
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }

    if (_currentPage == 0) {
      _productList.clear();
      _isInitialLoading = true;
    } else {
      _getProductInProgress = true;
    }
    update();
    _currentPage++;
    _getProductInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: "${Urls.allProductsUrl}?count=$_pageSize&page=$_currentPage",
    );

    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList = list;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProductInProgress = false;
    update();
    return isSuccess;
  }
}

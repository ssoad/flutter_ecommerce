import 'package:ecommerce_app/data/datasources/remote/apis/product_api.dart';
import 'package:ecommerce_app/presentation/home/binding/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../models/product_model.dart';

class HomeScreenController extends GetxController {
  Rx<List<Product>> _products = Rx<List<Product>>([]);
  List<Product> get products => _products.value;
  Rx<List<Map<String, dynamic>>> cartItems = Rx<List<Map<String, dynamic>>>([]);
  Rx<bool> isLoading = Rx<bool>(false);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Add your controller logic here

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getCartItems();
    // Call your API and update the products list
  }

  void addProduct(Product product) {
    _products.value.add(product);
  }

  void removeProduct(Product product) {
    _products.value.remove(product);
  }

  void getCartItems() {
    // check is initialized or not
    try {
      cartItems = Get.find<LocalStorageService>().cartItems;
    } catch (e) {
      print(e);
      Get.putAsync(() => LocalStorageService().init(), permanent: true)
          .whenComplete(
              () => cartItems = Get.find<LocalStorageService>().cartItems);
      cartItems = Get.find<LocalStorageService>().cartItems;
    } finally {
      cartItems.refresh();
    }
  }

  Future<void> getProducts() async {
    // Call your API and update the products list
    var response = await ProductAPI.getProductList().request();
    if (response != null) {
      _products.value =
          (response as List).map((e) => Product.fromJson(e)).toList();
    }
  }

  void openCart() {
    scaffoldKey.currentState?.openEndDrawer();
  }
}

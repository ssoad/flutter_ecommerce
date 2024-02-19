import 'dart:convert';
import 'dart:math';

import 'package:ecommerce_app/core/services/local_storage_service.dart';
import 'package:ecommerce_app/presentation/widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/datasources/remote/apis/product_api.dart';
import '../../home/models/product_model.dart';

class ProductDetailsController extends GetxController {
  Rx<Product> product = Rx<Product>(Product());
  Rx<bool> isLoading = Rx<bool>(false);
  Rx<int> quantity = Rx<int>(1);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    // getDetails();
  }

  @override
  void onReady() {
    super.onReady();
    Get.showOverlay(
      asyncFunction: getDetails,
      loadingWidget: const LoadingOverlay(),
    );
  }

  Future<void> getDetails() async {
    try {
      int id = Get.arguments;
      var result = await ProductAPI.getProductDetails(productId: id.toString())
          .request();
      if (result != null) {
        product.value = Product.fromJson(
            result.where((element) => element["id"] == id).first);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> addToCart() async {
    try {
      int a = await Get.find<LocalStorageService>().insertItem({
        "product": json.encode(product.value.toJson()).toString(),
        "quantity": quantity.value,
      });
      if (a > 0) {
        print('Product added to cart');
        Get.back();
        Get.snackbar('Success', 'Product added to cart',
            snackPosition: SnackPosition.TOP);
        quantity.value = 1;
        // Close BottomSheet
      } else {
        Get.back();
        print('Failed to add product to cart');
        Get.snackbar('Error', 'Failed to add product to cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void openCart() {
    scaffoldKey.currentState?.openEndDrawer();
  }
}

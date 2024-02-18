import 'package:get/get.dart';

import '../../../data/datasources/remote/apis/auth_api.dart';
import '../../home/models/product_model.dart';

class HomeScreenController extends GetxController {
  Rx<List<Product>> productList = Rx<List<Product>>([]);
  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  Future<void> getProductList() async {
    try {
      var result = await ProductAPI.getProductList().request();
      if (result != null) {
        productList.value = result.map((e) => Product.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}

import 'package:ecommerce_app/presentation/home/home_screen.dart';
import 'package:ecommerce_app/presentation/product_details_screen.dart/binding/product_details_binding.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../presentation/home/binding/home_binding.dart';
import '../../presentation/product_details_screen.dart/product_details_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String productDetails = '/product-details';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(
      name: productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
  ];
}

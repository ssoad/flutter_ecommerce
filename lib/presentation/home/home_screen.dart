import 'package:ecommerce_app/presentation/cart/cart_drawer.dart';
import 'package:ecommerce_app/presentation/home/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/local_storage_service.dart';
import '../widgets/product_widgets.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: const Text('TR Store'),
          actions: [
            Obx(() {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          controller.cartItems.value.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // Cart icon pressed logic
                  controller.openCart();
                },
              );
            }),
          ],
        ),
        body: Obx(() {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            children: controller.products
                .map((product) => ProductItemWidget(
                      product: product,
                    ))
                .toList(),
          );
        }),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       label: 'Cart',
        //     ),
        //   ],
        // ),
        endDrawer: Obx(() {
          return CartDrawer(
            cartItems: controller.cartItems.value,
          );
        }));
  }
}

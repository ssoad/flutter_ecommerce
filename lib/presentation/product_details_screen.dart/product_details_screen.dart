import 'package:ecommerce_app/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/cart_drawer.dart';
import 'controller/product_details_screen_controller.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('Product Details'),
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
                        Get.find<LocalStorageService>()
                            .cartItems
                            .value
                            .length
                            .toString(),
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Slideable Images
              controller.product.value.image != null
                  ? SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Image.network(
                            controller.product.value.image!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              // Product Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.product.value.title ?? 'Product Title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Price: \$${controller.product.value.userId?.toStringAsFixed(2) ?? 'Price'}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Product Details
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Product Details'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.product.value.content ?? 'Product Details',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
              // Product Price
            ],
          ),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add to Cart logic
      //   },
      //   child: const Icon(Icons.shopping_cart),
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Buy Now logic
                },
                child: const Text('Buy Now'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // int quantity = 1;
                  // OnPress Add to cart Button Show BottomSheet with Number of Quantity +- IconButton with Text
                  Get.bottomSheet(
                    const CartBottomSheet(),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Obx(() {
        return CartDrawer(
          cartItems: Get.find<LocalStorageService>().cartItems.value,
        );
      }),
    );
  }
}

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({
    super.key,
  });

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.find<ProductDetailsController>();
    quantity = controller.quantity.value;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // OnPress Minus Button
                  quantity--;
                  setState(() {
                    quantity = quantity;
                  });
                  controller.quantity.value = quantity;
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  // OnPress Plus Button
                  quantity++;
                  setState(() {
                    quantity = quantity;
                  });
                  controller.quantity.value = quantity;
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // OnPress Add to Cart Button
              controller.addToCart();
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
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
                    child: const Text(
                      '2',
                      style: TextStyle(
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Slideable Images
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Product Title
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Product Details
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Product Price
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Price: \$99.99',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
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
            SizedBox(width: 8),
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
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // OnPress Add to Cart Button
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

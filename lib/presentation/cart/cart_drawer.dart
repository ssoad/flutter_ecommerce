import 'dart:convert';

import 'package:flutter/material.dart';

class CartDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartDrawer({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    print(cartItems);
    double totalPrice = cartItems.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (jsonDecode(element["product"].toString())["userId"] *
                element["quantity"]));
    // double totalPrice = 100;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Text(
              'Cart Items',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          for (var item in cartItems)
            // ListTile with Image Placeholder
            ListTile(
              leading: Image.network(
                jsonDecode(item["product"].toString())["image"],
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(jsonDecode(item["product"].toString())["title"]),
              subtitle:
                  Text('Quantity: ${item["quantity"]}'), //${item.quantity}'),
              trailing: Text(
                  '\$${jsonDecode(item["product"].toString())["userId"] * item["quantity"]}'),
            ),
          const Divider(),
          ListTile(
            title: const Text('Total Price'),
            trailing: Text('\$${totalPrice.toString()}'),
          ),
        ],
      ),
    );
  }
}

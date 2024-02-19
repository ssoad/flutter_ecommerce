import 'dart:convert';

import '../../home/models/product_model.dart';

List<CartItem> cartFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  int? id;
  Product? product;
  int? quantity;

  CartItem({
    this.id,
    this.product,
    this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        product: json["product"] == null
            ? null
            : Product.fromJson(jsonDecode(json["product"].toString())),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "quantity": quantity,
      };
}

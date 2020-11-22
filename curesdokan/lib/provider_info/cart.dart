import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String id;
  final double price;
  final int quantity;

  CartItem({
    @required this.title,
    @required this.id,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  int get cartLength {
    return _items.length;
  }

  void removeItem(String k) {
    _items.removeWhere((key, value) => key == k);
    notifyListeners();
  }

  void addItem(String productId, String title, String price) {
    if (_items.containsKey(productId)) {
      //product have already in cart

      _items.update(
        productId,
        (existingItem) => CartItem(
          title: existingItem.title,
          id: existingItem.id,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          title: title,
          id: DateTime.now().toString(),
          price: double.parse(price),
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}

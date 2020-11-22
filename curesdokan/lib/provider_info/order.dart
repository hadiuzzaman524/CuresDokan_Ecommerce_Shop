import 'package:curesdokan/provider_info/cart.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  final double total;
  final List<CartItem> cartItems;
  final DateTime dateTime;
  final String id;

  OrderItem({this.total, this.cartItems, this.dateTime, this.id});
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  addItem(double total, List<CartItem> list) {
    _items.add(
      OrderItem(
        total: total,
        cartItems: list,
        dateTime: DateTime.now(),
        id: DateTime.now().toString(),
      ),
    );
    notifyListeners();
  }

  List<OrderItem> get allOrder{
    return [..._items];
  }

}

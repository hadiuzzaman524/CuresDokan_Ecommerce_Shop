import 'package:curesdokan/provider_info/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final double total;
  final List<CartItem> cartItems;
  final DateTime dateTime;
  final String id;

  OrderItem({this.total, this.cartItems, this.dateTime, this.id});
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  Future<void> addItem(double total, List<CartItem> list) async {
    final date = DateTime.now();
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/orders.json";
    final response = await http.post(url,
        body: json.encode({
          'total': total,
          'cartItems': list
              .map((p) => {
                    'id': p.id,
                    'title': p.title,
                    'quantity': p.quantity,
                    'price': p.price,
                  })
              .toList(),
          'dateTime': date.toIso8601String(),
        }));
    if(response.statusCode==200){
      _items.add(
        OrderItem(
          total: total,
          cartItems: list,
          dateTime: date,
          id: json.decode(response.body)['name'],
        ),
      );
      notifyListeners();
    }

  }

  List<OrderItem> get allOrder {
    return [..._items];
  }
}

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
  Order(this._token,this._items);
  List<OrderItem> _items = [];
  final _token;

  Future<void> addItem(double total, List<CartItem> list) async {
    final date = DateTime.now();
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/orders.json?auth=$_token";
    final response = await http.post(url,
        body: json.encode({
          'total': total,
          'dateTime': date.toIso8601String(),
          'cartItems': list
              .map((p) => {
                    'id': p.id,
                    'title': p.title,
                    'quantity': p.quantity,
                    'price': p.price,
                  })
              .toList(),
        }));
    if (response.statusCode == 200) {
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

  Future<void> fetchOrder() async {
    List<OrderItem> templist = [];
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/orders.json?auth=$_token";
    try {
      http.get(url).then((response) {
        if (response.statusCode == 200) {
          final extertData = json.decode(response.body) as Map<String, dynamic>;
          extertData.forEach((id, order) {
            templist.add(OrderItem(
              id: id,
              total: order['total'],
              dateTime: DateTime.parse(order['dateTime']),
              cartItems: (order['cartItems'] as List<dynamic>).map((e) {
                return CartItem(
                  id: e['id'],
                  price: e['price'],
                  title: e['title'],
                  quantity: e['quantity'],
                );
              }).toList(),
            ));
          });

         _items=[...templist];
          notifyListeners();
        } else {
          print('Error to return Orders');
        }
      });
    } catch (error) {
      print(error);
    }
  }

  List<OrderItem> get allOrder {
    return [..._items];
  }
}

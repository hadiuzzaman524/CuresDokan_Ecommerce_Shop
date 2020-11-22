import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/cart.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String k;
  final double price;
  final int quantity;
  final String id;

  CartItem({this.title, this.k, this.price, this.id, this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(k),
      onDismissed: (direction) {
        cart.removeItem(k);
      },
      background: Container(
        color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 30,
                child: FittedBox(
                  child: Text(
                    '${price.toStringAsFixed(0)}৳',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text('${(price * quantity).toStringAsFixed(0)}৳'),
              trailing: Text('${quantity}x'),
            ),
          ),
        ),
      ),
    );
  }
}

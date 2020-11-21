import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {

  final String title;
  final double price;
  final int quantity;
  final String id;
  CartItem({this.title,this.price,this.id,this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 30,
              child: FittedBox(
                child: Text(price.toStringAsFixed(0),
                style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ),
            title: Text(title),
            subtitle: Text((price*quantity).toStringAsFixed(0)),
            trailing: Text('${quantity}x'),
          ),
        ),
      ),
    );
  }
}

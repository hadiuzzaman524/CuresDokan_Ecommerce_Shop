import 'package:curesdokan/provider_info/cart.dart' show Cart;
import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Your shopping cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$${cart.totalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                        ),
                      ),
                      FlatButton(
                        onPressed: () => null,
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final x = cart.items.values.toList();
                  return CartItem(
                    title: x[index].title,
                    quantity: x[index].quantity,
                    id: x[index].id,
                    price: x[index].price,
                  );
                },
                itemCount: cart.cartLength,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

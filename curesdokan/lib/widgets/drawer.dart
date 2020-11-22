import 'package:curesdokan/screens/home_screen.dart';
import 'package:curesdokan/screens/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.orange,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'CuresDokan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.shopping_bag_rounded),
              title: Text('Shop'),
            ),
          ),
          Divider(),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Orders'),
            ),
          ),
        ],
      ),
    );
  }
}

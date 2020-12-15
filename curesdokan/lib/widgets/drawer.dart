import 'package:curesdokan/screens/home_screen.dart';
import 'package:curesdokan/screens/my_product_screen.dart';
import 'package:curesdokan/screens/order_screen.dart';
import 'package:curesdokan/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/auth.dart';

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
          Divider(),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MyProductScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Customize your products'),
            ),
          ),
          Divider(),
          FlatButton(
            onPressed: () async{
              await Provider.of<Auth>(context,listen: false).logOut();
              Navigator.pushReplacementNamed(context, RegistrationScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}

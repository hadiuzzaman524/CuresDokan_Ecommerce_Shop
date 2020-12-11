import 'package:curesdokan/provider_info/auth.dart';
import 'package:curesdokan/provider_info/cart.dart';
import 'package:curesdokan/provider_info/order.dart';
import 'package:curesdokan/provider_info/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './screens/details_screen.dart';
import './screens/order_screen.dart';
import './screens/my_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/registration_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Products(),
      ),
      ChangeNotifierProvider(
        create: (_) => Cart(),
      ),
      ChangeNotifierProvider(
        create: (_) => Order(),
      ),
      ChangeNotifierProvider(
        create: (_) => Auth(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: RegistrationScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        OrderScreen.routeName: (context) => OrderScreen(),
        MyProductScreen.routeName: (context) => MyProductScreen(),
        EditProductScreen.routeName: (context) => EditProductScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
      },
    );
  }
}

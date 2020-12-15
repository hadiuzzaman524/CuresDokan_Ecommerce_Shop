import 'package:curesdokan/models/data_model.dart';
import 'package:curesdokan/provider_info/auth.dart';
import 'package:curesdokan/provider_info/cart.dart';
import 'package:curesdokan/provider_info/order.dart';
import 'package:curesdokan/provider_info/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        create: (_) => Auth(),
      ),
      /*
      When need one provider class data to another then we can pass data easily using
      proxyprovider. in proxyprovider taken two argument first one is provide value,
      and second one is user of this value.
      update () taken three argument context, provided class object and user class previous created object.

       */
      ChangeNotifierProxyProvider<Auth, Products>(
        update: (ctx, auth, previousProduct) => Products(
          auth.getToken,
          auth.getUserId,
          previousProduct == null ? [] : previousProduct.productList,
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => Cart(),
      ),
      ChangeNotifierProxyProvider<Auth, Order>(
        update: (ctx, auth, previousOrder) => Order(
            auth.getToken, previousOrder == null ? [] : previousOrder.allOrder),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) {
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
          home: auth.isAuth ? HomeScreen() : RegistrationScreen(),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            DetailsScreen.routeName: (context) => DetailsScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            MyProductScreen.routeName: (context) => MyProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            RegistrationScreen.routeName: (context) => RegistrationScreen(),
          },
        );
      },
    );
  }
}

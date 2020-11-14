import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/details_screen.dart';

void main() {
  runApp(MyApp());
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
      },
    );
  }
}

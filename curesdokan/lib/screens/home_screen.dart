import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CuresDokan',
          ),
        ),
        body: GridItem(),
      ),
    );
  }
}

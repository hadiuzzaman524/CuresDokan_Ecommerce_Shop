import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName='/DetailsScreen';

  @override
  Widget build(BuildContext context) {

    final String productId=ModalRoute.of(context).settings.arguments as String;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Text(productId),
      ),
    ));
  }
}

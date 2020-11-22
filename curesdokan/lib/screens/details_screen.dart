import 'package:curesdokan/provider_info/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/DetailsScreen';

  @override
  Widget build(BuildContext context) {
    final productsInfo = Provider.of<Products>(context);

    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: Column(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              child: Image.network(
                productsInfo.productList
                    .firstWhere((element) => element.id == productId)
                    .imageUrl
                    .toString(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              width: double.infinity,
              child: Text(
                productsInfo.productList
                    .firstWhere((element) => element.id == productId)
                    .description
                    .toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

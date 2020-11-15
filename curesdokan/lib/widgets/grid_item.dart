import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../provider_info/products.dart';

class GridItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productList=Provider.of<Products>(context).productList;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 4 / 3,
        crossAxisCount: 2,
      ),
      itemCount: productList.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return ProductItemDesign(
          id: productList[index].id,
          title: productList[index].title,
          imageUrl: productList[index].imageUrl,
        );
      },
    );
  }
}
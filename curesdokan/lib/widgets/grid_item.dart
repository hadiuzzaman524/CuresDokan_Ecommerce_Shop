import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../provider_info/products.dart';

class GridItem extends StatelessWidget {
  final bool isFev;

  GridItem({this.isFev});

  @override
  Widget build(BuildContext context) {
    final productList = isFev
        ? Provider.of<Products>(context).favProductList
        : Provider.of<Products>(context).productList;
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
        /*
        If need to access previous data then use .value constructor
        it is more efficient for work with previous object.
         */
        return ChangeNotifierProvider.value(
          value: productList[index],
          child: ProductItemDesign(),
        );
      },
    );
  }
}

import 'package:curesdokan/screens/edit_product_screen.dart';
import 'package:curesdokan/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/products.dart';
import '../widgets/single_product.dart';

class MyProductScreen extends StatelessWidget {
  static const routeName = '/MyProductScreen';

 Future<void> refress(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).fetchProduct(false);
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('My Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => refress(context),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ShowSingleProduct(
                      id: products.productList[index].id,
                      title: products.productList[index].title,
                      imageUrl: products.productList[index].imageUrl,
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: products.productList.length,
            ),
          ),
        ),
      ),
    );
  }
}

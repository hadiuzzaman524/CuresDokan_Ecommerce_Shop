import 'package:curesdokan/models/data_model.dart';
import 'package:curesdokan/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/cart.dart';

class ProductItemDesign extends StatefulWidget {
  @override
  _ProductItemDesignState createState() => _ProductItemDesignState();
}

class _ProductItemDesignState extends State<ProductItemDesign> {
  bool addcart = false;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailsScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: Container(
          height: 35,
          width: MediaQuery.of(context).size.width,
          color: Colors.purple.withOpacity(0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  product.toggleFav();
                },
                child: Consumer<Product>(
                  /*
                    Consumer can not rebuild whole widget , when some change
                    occur it just change specific area. for working with that need to
                    listen:false in Provider.of<>(listen:false)
                     */
                  builder: (ctx, product, _) => Icon(
                    /*
                      this builder take 3 parameter first one is context, second one is
                      object and third one is child. it is optional option.
                       */
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                product.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    addcart = true;
                  });
                  cart.addItem(
                      product.id, product.title, product.price.toString());
                },
                child: addcart
                    ? Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.shopping_cart_outlined,
                        color: CupertinoColors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

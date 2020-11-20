import 'package:curesdokan/models/data_model.dart';
import 'package:curesdokan/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemDesign extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routeName,
                  arguments:product.id);
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
                    builder: (ctx,product,_)=>Icon(
                      /*
                      this builder take 3 parameter first one is context, second one is
                      object and third one is child. it is optional option.
                       */
                      product.isFavorite?Icons.favorite:Icons.favorite_border,
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
                    onTap: () {},
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
    );
  }
}

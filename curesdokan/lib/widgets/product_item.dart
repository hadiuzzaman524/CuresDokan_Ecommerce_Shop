import 'package:flutter/material.dart';

class ProductItemDesign extends StatefulWidget {
  final String title;
  final String imageUrl;

  ProductItemDesign({this.title, this.imageUrl});

  @override
  _ProductItemDesignState createState() => _ProductItemDesignState();
}

class _ProductItemDesignState extends State<ProductItemDesign> {
  bool fav = false;

  bool cart = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: GridTile(
        child: Image.network(widget.imageUrl,
        fit: BoxFit.cover,),
        footer: Container(
          height: 35,
          width: MediaQuery.of(context).size.width,
          color: Colors.purple.withOpacity(0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    fav = !fav;
                  });
                },
                child: fav
                    ? Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cart = !cart;
                  });
                },
                child: cart
                    ? Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

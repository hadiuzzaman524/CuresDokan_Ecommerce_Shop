import 'package:curesdokan/provider_info/products.dart';
import 'package:curesdokan/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grid_item.dart';
import '../widgets/badge.dart';
import '../provider_info/cart.dart';
import '../widgets/drawer.dart';

enum Choice {
  favorite,
  all,
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  bool firstTime = true;
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstTime) {
      await Provider.of<Products>(context).fetchProduct(true);
    }
    firstTime = false;
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refresh(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text(
            'CuresDokan',
          ),
          actions: [
            /*
            Consumer just rebuild of wrapped area not whole widget and make code
            faster. that's why used consumer
             */
            Consumer<Cart>(
              builder: (context, cart, ch) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                child: Badge(
                  /*
                  here (_,cart,_) is the Cart Object, and ch is Child not used this
                  scenario
                   */
                  child: Icon(Icons.add_shopping_cart_outlined),
                  value: cart.cartLength.toString(),
                ),
              ),
            ),
            PopupMenuButton(
              onSelected: (Choice selectedValue) {
                if (Choice.favorite == selectedValue) {
                  setState(() {
                    isFavorite = true;
                  });
                } else {
                  setState(() {
                    isFavorite = false;
                  });
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Favorite'),
                  value: Choice.favorite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: Choice.all,
                ),
              ],
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => refresh(context),
                child: GridItem(
                  isFev: isFavorite,
                ),
              ),
      ),
    );
  }
}

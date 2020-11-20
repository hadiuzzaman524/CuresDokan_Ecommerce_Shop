import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';


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

  bool isFavorite=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CuresDokan',
          ),
          actions: [
            PopupMenuButton(
              onSelected: (Choice selectedValue) {
                if (Choice.favorite == selectedValue) {
                  setState(() {
                    isFavorite=true;
                  });

                } else {
                  setState(() {
                    isFavorite=false;
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
        body: GridItem(isFev: isFavorite,),
      ),
    );
  }
}

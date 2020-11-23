import 'package:flutter/material.dart';

class ShowSingleProduct extends StatelessWidget {
  final String title;
  final String imageUrl;
  ShowSingleProduct({this.title,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.red,),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

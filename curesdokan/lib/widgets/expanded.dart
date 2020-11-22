import 'package:flutter/material.dart';
import '../provider_info/order.dart';

class ExpandedOrder extends StatelessWidget {
  const ExpandedOrder({
    Key key,
    @required this.index,
    @required this.order,
  }) : super(key: key);

  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      height: 150,
      child: ListView.builder(itemBuilder: (context, i) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.allOrder[index].cartItems
                    .toList()[i]
                    .title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),),
                Text(
                    '${order.allOrder[index].cartItems
                        .toList()[i]
                        .price
                        .toStringAsFixed(0)}৳'
                ),
              ],
            ),
            Divider(),
          ],
        );
      },
        itemCount: order.allOrder[index].cartItems.length,),
    );
  }
}

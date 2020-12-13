import 'package:flutter/material.dart';
import '../provider_info/order.dart';
import 'package:intl/intl.dart';
import '../widgets/expanded.dart';
import 'package:flutter/cupertino.dart';

class OrderDetails extends StatefulWidget {
  final int index;
  final Order order;

  OrderDetails(this.index, this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          key: ValueKey(DateTime.now()),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: FittedBox(
              child: Text(
                '${widget.order.allOrder[widget.index].total.toStringAsFixed(0)}৳',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(DateFormat('dd-mm-yy,  hh:mm')
              .format(widget.order.allOrder[widget.index].dateTime)),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: expanded ? Icon(Icons.expand_more) : Icon(Icons.expand_less),
          ),
        ),
        if (expanded) ExpandedOrder(order: widget.order, index: widget.index),
      ],
    );
  }
}

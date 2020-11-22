import 'package:curesdokan/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/order.dart';
import 'package:intl/intl.dart';
import '../widgets/expanded.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: order.allOrder.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 30,
                              child: FittedBox(
                                child: Text(
                                  '${order.allOrder[index].total.toStringAsFixed(0)}৳',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(DateFormat('dd-mm-yy,  hh:mm')
                                .format(order.allOrder[index].dateTime)),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  expanded = !expanded;
                                });
                              },
                              child: expanded
                                  ? Icon(Icons.expand_more)
                                  : Icon(Icons.expand_less),
                            ),
                          ),
                          if (expanded)
                            ExpandedOrder(order: order,index:index),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: order.allOrder.length,
              )
            : Center(
                child: Text('Order List is Empty'),
              ),
      ),
    );
  }
}

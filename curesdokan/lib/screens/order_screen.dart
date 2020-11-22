import 'package:curesdokan/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/order.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

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
                      child: ListTile(
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
                        trailing: Icon(Icons.keyboard_arrow_down),
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

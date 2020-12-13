import 'package:curesdokan/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_info/order.dart';
import 'package:intl/intl.dart';
import '../widgets/expanded.dart';
import '../utilities/order_details.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool expanded = false;
  bool isFirst = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isFirst) {
      await Provider.of<Order>(context, listen: false).fetchOrder();
    }
    isFirst = false;
  }

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
                      child: OrderDetails(index, order),
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

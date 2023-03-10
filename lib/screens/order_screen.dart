import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation/my_drawer.dart';
import '../widgets/orders_list.dart';
import '../widgets/finished_orders_list.dart';
import '../providers/orders_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.grey),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('Pedidos',
              style: TextStyle(
                  color: Colors.black, fontFamily: "Acme", fontSize: 24)),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: TabBar(
              labelColor: Color(0xFFf65c05),
              indicatorColor: Color(0xFFf65c05),
              unselectedLabelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  child: Text('Em andamento',
                      style:
                          TextStyle(color: Colors.black, fontFamily: "Acme")),
                ),
                Tab(
                  child: Text('Histórico',
                      style:
                          TextStyle(color: Colors.black, fontFamily: "Acme")),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: OrderList(),
            ),
            Center(
              child: FinishedOrderList(),
            ),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}

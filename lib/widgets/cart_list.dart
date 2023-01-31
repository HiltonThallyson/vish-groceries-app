import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'cart_item.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  CartListState createState() => CartListState();
}

class CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) => ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: cartProvider.cartProducts.length,
            itemBuilder: ((context, index) =>
                CartItem(cartProvider.cartProducts[index])),
          ),
        ));
  }
}

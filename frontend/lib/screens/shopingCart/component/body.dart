import 'package:flutter/material.dart';
import 'package:shop_app/screens/shopingCart/component/itemCard.dart';
import 'package:shop_app/models/Product.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index)=>ItemCard(item: products[index]),
      )
    );
  }
}
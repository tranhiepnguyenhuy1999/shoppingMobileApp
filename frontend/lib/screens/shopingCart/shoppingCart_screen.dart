import 'package:flutter/material.dart';
import 'package:shop_app/screens/shopingCart/component/body.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng của bạn"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.delete))
        ],
      ),
      body: Body(),
    );
  }
}
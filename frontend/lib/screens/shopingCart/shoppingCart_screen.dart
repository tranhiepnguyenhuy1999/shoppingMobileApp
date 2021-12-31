import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/controller/userToken_controller.dart';
import 'package:shop_app/screens/author/login_screen.dart';
import 'package:shop_app/screens/shopingCart/component/body.dart';

CartController _controller = Get.put(CartController());

class ShoppingCartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng của bạn", style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
              leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black45,
        ),
        onPressed: () => Navigator.pop(context),
      ),
        actions: [
          IconButton(onPressed:(){_controller.clearAll();}, icon: Icon(Icons.delete), color: Colors.black45,)
        ],
      ),
      body: Body(),
    );
  }
}
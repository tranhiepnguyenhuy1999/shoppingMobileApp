import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/screens/order/component/body.dart';

class OrderScreen extends StatelessWidget {

  CartController _controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin hóa đơn", style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
              leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black45,
        ),
        onPressed: () => Navigator.pop(context),
      )
      ),
      body: Body(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/controller/userToken_controller.dart';
import 'package:shop_app/screens/add_product/add_product.dart';
import 'package:shop_app/screens/author/login_screen.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/order/order_screen.dart';
import 'package:shop_app/screens/shopingCart/shoppingCart_screen.dart';
CartController _controller = Get.put(CartController());
UserTokenController _tokenController = Get.put(UserTokenController());
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.history),
          // By default our  icon color is white
          color: kTextColor,

          onPressed: () {
            if(_tokenController.isLogin.value)
            {
              Get.to(OrderScreen());
            }
            else 
            {
              Get.to(LoginScreen());
            }
          },
        ),
        Stack(
          children:[
            IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              // By default our  icon color is white
              color: kTextColor,
            ),
            onPressed: () {
              if(_tokenController.isLogin.value)
              {
                Get.to(ShoppingCartScreen());
              }
              else 
              {
                Get.to(LoginScreen());
              }
            }
          ),
          _controller.count.value>0
          ?
          Obx(()=> Positioned(
            top:5,
            right:5,
            child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text("${_controller.count}", style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),)
          )))
          :
          Text("")
          ]),
      ],
    );
  }
}

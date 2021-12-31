import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/screens/add_product/add_product.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/shopingCart/shoppingCart_screen.dart';
CartController _controller = Get.put(CartController());
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      drawer: Drawer(
        child: Text("huy"),
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () => {Navigator.pop(context)},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          // By default our  icon color is white
          color: kTextColor,

          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2),
        Stack(
          children:[
            IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              // By default our  icon color is white
              color: kTextColor,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(),
                )),
          ),
          if(_controller.count.value>0)
          Obx(()=> Positioned(
            top:5,
            right:5,
            child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text("${_controller.count}", style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),)
          )))
          ]),
      ],
    );
  }
}

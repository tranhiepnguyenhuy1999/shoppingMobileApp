import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/models/Product%20copy.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/shopingCart/shoppingCart_screen.dart';

import '../../../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
 
CartController _controller = Get.put(CartController());

class AddToCart extends StatelessWidget {

  final Product product;
  final int numOfItems;
  const AddToCart({
    Key key,
    @required this.product,
    this.numOfItems
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: Colors.black,
              ),
              onPressed: () {_controller.addCart(CartItemM.fromProduct(product, numOfItems));
              Fluttertoast.showToast(
                msg: "Thêm sản phẩm vào giỏ hàng thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );},
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.black,
                onPressed: () {_controller.addCart(CartItemM.fromProduct(product, 1)); Get.to(ShoppingCartScreen());},
                child: Text(
                  "Mua ngay".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

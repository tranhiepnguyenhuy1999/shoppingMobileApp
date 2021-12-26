import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int numOfItems = 1;
  Function countNum (value, key) {
      switch (key) {
        case "+":
          setState(() {
            numOfItems += value;
          });
          break;
        case "-":
          setState(() {
            numOfItems -= value;
          });
          break;
        default:
          setState(() {
            numOfItems = value;
          });
          break;
      }
  }
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ColorAndSize(product: widget.product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: widget.product),
                      SizedBox(height: kDefaultPaddin / 2),
                      CounterWithFavBtn(numOfItems: numOfItems, countNum: countNum),
                      SizedBox(height: kDefaultPaddin / 2),
                      AddToCart(product: widget.product, numOfItems: numOfItems),
                      SizedBox(height: kDefaultPaddin / 2),
                      Text("Nhận xét và Đánh giá (0)", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(height: kDefaultPaddin / 2),
                      Text("Hiện tại chưa có nhận xét nào về sản phẩm"),
                      SizedBox(height: kDefaultPaddin / 2),

                    ],
                  ),
                ),
                ProductTitleWithImage(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }
}

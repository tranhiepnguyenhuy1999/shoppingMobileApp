import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
var f = NumberFormat('###,###,000');
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
          Container(
            width: double.maxFinite,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.black12 ,
              image: DecorationImage(
                  image:  NetworkImage(widget.product.image),
                  fit: BoxFit.contain
                )
            ),
          ),
          SizedBox(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: kDefaultPaddin,
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
                      Text("${f.format(widget.product.price)} ₫", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.pinkAccent)),
                      SizedBox(height: kDefaultPaddin / 2),
                      Text(widget.product.title, style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                      SizedBox(height: kDefaultPaddin),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            Text("100% Chính hãng"),
                            Text("Miễn phí giao hàng"),
                            Text("Giá tốt vô đối")
                          ],
                        ),
                      ),
                      SizedBox(height: kDefaultPaddin),
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
                      SizedBox(height: kDefaultPaddin * 2),

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(kDefaultPaddin),
                // For  demo we use fixed height  and width
                // Now we dont need them
                // height: 180,
                // width: 160,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Hero(
                  tag: "${product.id}",
                  child: Image.asset(product.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4, horizontal: 5.0),
              child: Text(
                // products is out demo list
                product.title,
                style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                "\$${product.price}",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "${product.address}",
                style: TextStyle(color: kTextLightColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

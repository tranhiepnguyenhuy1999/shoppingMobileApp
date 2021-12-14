import 'package:flutter/material.dart';
import 'package:shop_app/models/Product%20copy.dart';
import 'package:shop_app/screens/details/components/cart_counter.dart';
import 'package:shop_app/screens/shopingCart/component/cartCounter.dart';

class ItemCard extends StatelessWidget {
  final CartItemM item;
  final Function press;
  const ItemCard({
    Key key,
    this.item,
    this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Container(
      padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: press,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage(item.image),
                  fit: BoxFit.fill
                )
              ),
            ),
          ),
          Expanded(child: 
           Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("${item.title}", style: TextStyle(fontSize: 13)),
                 Expanded(child: Container(),),         
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text("${item.price} VNĐ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red)),
                    CartShoppingCounter(amount: item.amount),
                   ]
                 )
               ]
             ),
           )
          )
        ],
      ) ,
    ),
    );
  }
}
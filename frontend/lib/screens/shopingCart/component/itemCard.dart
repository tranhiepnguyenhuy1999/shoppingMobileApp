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
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: press,
            child: Container(
              width: 120,
              height: 120,
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
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Text("${item.price} VNĐ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Thành tiền: ${item.price*item.amount}", style: TextStyle(fontWeight: FontWeight.bold)),
                      CartShoppingCounter(amount: item.amount, id: item.id)]),
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
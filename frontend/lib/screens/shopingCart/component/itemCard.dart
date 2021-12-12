import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

class ItemCard extends StatelessWidget {
  final Product item;

  const ItemCard({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage(item.image),
                fit: BoxFit.fill
              )
            ),
          ),
          Expanded(child: 
           Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("${item.title}", style: TextStyle(fontSize: 15)),          
                 Text("${item.price} VNĐ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red))
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
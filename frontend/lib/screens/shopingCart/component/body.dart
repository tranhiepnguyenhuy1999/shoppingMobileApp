import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/shopingCart/component/itemCard.dart';
import 'package:shop_app/models/Product.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index)=>ItemCard(item: products[index], press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: products[index],
                              ),
                            )),),
        )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: TextField(
          decoration: const InputDecoration(
          hintText: "",
          labelText: 'Mã giảm giá',
        ),
        ),
      )
      ,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Tổng tiền: ${200000}"),
            Expanded(child: Container()),
            TextButton(onPressed: (){}, child: 
            Text("Thanh toán")
            )
          ],
        ),
      )
      ]
    );
  }
}
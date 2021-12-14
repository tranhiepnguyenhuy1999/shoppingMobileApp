import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/shopingCart/component/itemCard.dart';
import 'package:shop_app/models/Product.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  CartController _controller = Get.put(CartController());
  
  int totalMoney= products.fold(0, (prev, element) => prev+ element.price);
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(
        child: Obx(()=>
          ListView.builder(
          itemCount: _controller.product.value.length,
          itemBuilder: (context, index)=>ItemCard(item: _controller.product[index], press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: _controller.product[index],
                              ),
                            )),),
        )
          ),
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
            Text("Tổng tiền: ${totalMoney}"),
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
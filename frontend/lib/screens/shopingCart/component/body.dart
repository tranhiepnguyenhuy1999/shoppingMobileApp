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
  
  int totalMoney = 0;
  @override
  initState() {
    super.initState();
    setState(() {
      totalMoney= _controller.product.value.fold(0, (prev, element) => prev+ element.price*element.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(
        child: _controller.product.length !=0
        ?
        Obx(()=>
          ListView.builder(
          itemCount: _controller.product.value.length,
          itemBuilder: (context, index)=>ItemCard(item: _controller.product.value[index], press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: _controller.product[index],
                              ),
                            )),),
        )
        )
        :
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Giỏ hàng trống"),
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
            Obx(()=>Text("Tổng tiền: ${_controller.product.fold(0, (prev, element) => prev+ element.price*element.amount)}")),
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
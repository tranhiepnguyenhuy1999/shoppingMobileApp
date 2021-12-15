import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controller/cart_controller.dart';

CartController _controller = Get.put(CartController());

class CartShoppingCounter extends StatelessWidget {
  final int amount;
  final Function press;
  final int id;
  const CartShoppingCounter({
  Key key,
  this.amount,
  this.press,
  this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if(amount>0)
              _controller.changeAmountById(id, amount-1);
          },
        ), 
         SizedBox(
            width: 35,
            child: TextButton(
              child: Text("${amount}", style: TextStyle(fontSize: 15, color: Colors.black)),
              onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: SizedBox(
                  width: double.maxFinite,
                  child: TextField(
                    onSubmitted: (value) => {
                      if(value != null)
                      {
                        _controller.changeAmountById(id, int.parse(value)),
                        Navigator.pop(context)
                      }
                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Nhập số lượng',
                    )
                  ),
                ),
              ),
            ),
            ),
          ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
            _controller.changeAmountById(id, amount+1);
            }),
      ],
    );
  }
}

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 25,
      height: 25,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: press,
        child: Icon(icon, size: 13,),
      ),
    );
  }
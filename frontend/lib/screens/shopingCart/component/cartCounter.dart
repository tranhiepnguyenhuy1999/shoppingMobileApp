import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class CartShoppingCounter extends StatelessWidget {
  final int amount;
  final Function press;
  const CartShoppingCounter({
  Key key,
  this.amount,
  this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {},
        ),  
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 4),
          child: SizedBox(
            width: 50,
            child: TextButton(
               onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: TextField(
              onChanged: (value) => {
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
              child: Text("${amount}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black))
            ),
          )
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
        
            }),
      ],
    );
  }
}

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
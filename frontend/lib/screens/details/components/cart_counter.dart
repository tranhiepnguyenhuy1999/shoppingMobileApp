import 'package:flutter/material.dart';

import '../../../constants.dart';

class   CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
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
                if(value != null)
                setState(() {
                numOfItems= int.parse(value);
              })},
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nhập số lượng',
              )
            ),
          ),
        ),
      ),
              child: Text("${numOfItems}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black))
            ),
          )
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
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
}

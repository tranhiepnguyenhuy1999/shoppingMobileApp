import 'package:flutter/material.dart';

import '../../../constants.dart';

class   CartCounter extends StatelessWidget {

  final int numOfItems;
  final Function countNum;
  const CartCounter({
    this.numOfItems,
    this.countNum,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if(numOfItems>0)
            {
            countNum(1, "-");
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
                if(value !=null)
                {
                  countNum(int.parse(value), "")
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
              child: Text("${numOfItems}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black))
            ),
          )
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              countNum(1,"+");
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

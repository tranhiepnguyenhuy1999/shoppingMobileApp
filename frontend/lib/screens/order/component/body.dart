import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/controller/userToken_controller.dart';
import 'package:shop_app/models/Bill.dart';
import 'package:shop_app/models/ReportBill.dart';
import 'package:shop_app/screens/bill/component/itemCard.dart';
import 'package:shop_app/screens/order/component/orderDetail.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  CartController _controller = Get.put(CartController());
  UserTokenController _userTokenControllercontroller = Get.put(UserTokenController());

  List<Order> orders= List();
  void fetchData () async {
    var headers= {"Content-Type": "application/json", "Authorization": _userTokenControllercontroller.userToken.value};
    // await Future.delayed( Duration(milliseconds: 1000));
    var response = await http.get(Uri.parse('http://192.168.0.104:4007/v1/app/order'), headers: headers);
    if(response.statusCode == 200)
    { 

      var data = json.decode(response.body);

      if(ReportBillJSON.fromJson(data).code !=0){
        Fluttertoast.showToast(
        msg: ReportBillJSON.fromJson(data).message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
       );
       
       return;

      }
      setState(() {
        orders=ReportBillJSON.fromJson(data).data.orders;
      });
      // for (var item in data)
      // {

      // }
    }
    else{
      return;
    }
    print(response.body);
    setState(() {
      loading: false;
    });
  }
  
  @override
  initState() {
    super.initState();
    fetchData();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Expanded (
        child: SingleChildScrollView(
          child: Column(children: [ for ( var i in orders) OrderDetail(order: i)]),
        ),
      ),
      ]
    );
  }
}

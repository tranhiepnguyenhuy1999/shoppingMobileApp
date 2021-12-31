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
    setState(() {
      loading: true;
    });
    var headers= {"Content-Type": "application/json", "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQwODM3NDA0LCJleHAiOjE2NDM0Mjk0MDR9.9906SlatJc3Q7HYLQHLbBzmGppSrm7Z_K3rpit13xDw"};
    // await Future.delayed( Duration(milliseconds: 1000));
    var response = await http.get(Uri.parse('http://192.168.0.104:4007/v1/app/order'), headers: headers);
    if(response.statusCode == 200)
    { 
      var data = json.decode(response.body);
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

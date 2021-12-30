import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/ReportBill.dart';
import 'package:shop_app/screens/main/main_page.dart';
import 'package:shop_app/screens/order/order_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends GetMaterialApp {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

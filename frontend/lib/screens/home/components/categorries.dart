import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Category.dart';

import '../../../constants.dart';
// We need satefull widget for our categories

class Categories extends StatefulWidget {
  final Function press;
  const Categories({Key key, this.press}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<ProductCategory> categories = List();
  // By default our first item will be selected
  int selectedIndex = 0;
    void fetchData () async {
    try{  
    var response = await http.get(Uri.parse('http://192.168.0.104:4007/v1/app/category'));
    if(response.statusCode == 200)
    { 
      var data = json.decode(response.body);
      setState(() {
        categories= CategoryJSON.fromJson(data).data.categories;
      });
    }
    }on TimeoutException catch (_) {
      print(_);
    } on SocketException catch (_) {
      // Other exception
    }

  }

  @override 
  initState() {
    super.initState();
    // Add listeners to this class  
    fetchData();
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Container(
        height: 30,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        widget.press(categories[index].id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin/4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.grey[300] : Colors.transparent,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                categories[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? kTextColor : kTextLightColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

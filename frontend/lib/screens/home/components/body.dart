import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/ProductJSON.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import 'categorries.dart';
import 'item_card.dart';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {


  List<Product> productList= List();

  ScrollController _controller= new ScrollController();

  bool loading = false;
  bool isLoadingDone = false;
  int selectedCategoryId=null;

  void fetchData () async {
    if(isLoadingDone) return;
    setState(() {
      loading: true;
    });
    // await Future.delayed( Duration(milliseconds: 1000));
    try
    {
      var response = await http.get(Uri.parse('http://192.168.0.104:4007/v1/app/product?category=${selectedCategoryId}')).timeout(const Duration(seconds: 10));
      // var response = await http.get(Uri.parse('http://gondar.gotdns.ch/v1/app/product'));
      if(response.statusCode == 200)
      { 
        var data = json.decode(response.body);
        print(data);
        setState(() {
          productList=ProductJSON.fromJson(data).data.products;
        });
      }
      else {
        setState(() {
          productList=[];
        });
        return;
      }
    }on TimeoutException catch (_) {
      print(_);
    } on SocketException catch (_) {
      // Other exception
    }
    catch(err) {
      print("erro ${err}");
    }

    setState(() {
      loading: false;
    });
  }
  void changeSelectedCategoryId (id) {
    setState(() {
      selectedCategoryId=id;
    });
    fetchData();
  }
  @override 
  initState() {
    super.initState();
    // Add listeners to this class  
    fetchData();
    _controller.addListener(() {
      if(_controller.position.pixels >= _controller.position.maxScrollExtent)
      {
        fetchData();
      }
    });
  }
  
  @override
   void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        CarouselSlider(
        options: CarouselOptions(height: 150.0),
        items: [1,2,3,4].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner${i}.png"),
                    fit: BoxFit.cover
                  )
                ),
              );
            },
          );
        }).toList(),
      ),
        Categories(press: changeSelectedCategoryId),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin, vertical: kDefaultPaddin/4),
            child: GridView.builder(
                controller: _controller,
                itemCount: productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin/2,
                  crossAxisSpacing: kDefaultPaddin/2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: productList[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: productList[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}

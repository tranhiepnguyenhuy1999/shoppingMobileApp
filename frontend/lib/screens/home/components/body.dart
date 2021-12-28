import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {


  final List<Product> productList= [];

  ScrollController _controller= new ScrollController();

  bool loading = false;
  bool isLoadingDone = false;
  void fetchData () async {
    if(isLoadingDone) return;
    setState(() {
      loading: true;
    });
    await Future.delayed( Duration(milliseconds: 1000));
    if(productList.length >=60)
    {
      setState(() {
        isLoadingDone: true;
      });
    }
    else
    {
      setState(() {
        productList: productList.addAll(products);
      });
    }
    setState(() {
      loading: false;
    });
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
                  color: Colors.amber,
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner${i}.png"),
                    fit: BoxFit.cover
                  )
                ),
                child: Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
      ),
        Categories(),
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

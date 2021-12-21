import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/screens/bill/component/itemCard.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  CartController _controller = Get.put(CartController());
  final formKey= GlobalKey<FormState>();
  int totalMoney = 0;
  @override
  initState() {
    super.initState();
    setState(() {
      totalMoney= _controller.product.fold(0, (prev, element) => prev+ element.price*element.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded (
        child: SingleChildScrollView(
          child: Column(
            children:[ 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: OutlinedButton(
                style: ButtonStyle(
                ),
                child: SizedBox(width: double.maxFinite, child: Text("Nhập thông tin giao hàng")),
                onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                color: Colors.white,
                child: Center(
                  child: Form(
            key: formKey,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("ThÔNG TIN GIAO HÀNG", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                  SizedBox(height: 10.0,),
                  buildPhoneTextFormField(),
                  SizedBox(height: 10.0,),
                  buildNameTextFormField(),
                  SizedBox(height: 10.0,),
                  buildAddressTextFormField(),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                    onTap: (){
                      bool isValid = formKey.currentState.validate();
                      if(isValid)
                      {
                        formKey.currentState.save();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Lưu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                    ),
                  )
                ],
          ),
            ),
        )
                ),
              );
            },
          );
          },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Row(
                children: [
                  Text("Danh sách sản phẩm"),
                  Expanded(child: Container()),
                  IconButton(onPressed:(){_controller.clearAll();}, icon: Icon(Icons.delete), color: Colors.black45)
                ],
              ),
            ),
            _controller.product.length !=0
            ?
            Obx(()=>  
              Column(
                children: [
                  for ( var i in _controller.product) ItemCard(item: i, press: () =>{})
                ],
              )
            )
            :
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Giỏ hàng trống"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: TextField(
                decoration: const InputDecoration(
                hintText: "",
                labelText: 'Nhập mã giảm giá (Mã chỉ áp dụng 1 lần)',
              ),
              ),
            ),
            Text("Phí giao hàng: 000000"),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Obx(()=>Text("Tổng cộng: ${_controller.product.fold(0, (prev, element) => prev+ element.price*element.amount)}")),
            Expanded(child: Container()),
            TextButton(onPressed: (){}, child: 
            Text("Đặt hàng")
            )
          ],
        ),
      )
      ]
    );
  }

    Widget buildPhoneTextFormField() => TextFormField(
    decoration: const InputDecoration(
    icon: Icon(Icons.phone),
    hintText: 'Phone',
    labelText: 'Phone *',
  ),
    validator: (String value){
      return (value=="")?"Vui lòng nhập SDT":null;
    },
    onSaved: (value){setState(() {
      phone: value;
    });},
  );
    Widget buildNameTextFormField() => TextFormField(
    decoration: const InputDecoration(
    icon: Icon(Icons.person),
    hintText: 'Tên người nhận',
    labelText: 'Tên người nhận *',
  ),
    validator: (String value){
      return (value=="")?"Vui lòng nhập thông tin người nhận":null;
    },
    onSaved: (value){setState(() {
      name: value;
    });},
  );
    Widget buildAddressTextFormField() => TextFormField(
    decoration: const InputDecoration(
    icon: Icon(Icons.location_city),
    hintText: 'Địa chỉ giao hàng',
    labelText: 'Địa chỉ *',
  ),
    validator: (String value){
      return (value=="")?"Vui lòng nhập Địa chỉ giao hàng":null;
    },
    onSaved: (value){setState(() {
      address: value;
    });},
  );

}
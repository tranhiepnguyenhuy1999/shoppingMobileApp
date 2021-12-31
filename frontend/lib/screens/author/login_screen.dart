import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/controller/userToken_controller.dart';
import 'package:shop_app/models/TokenJSON.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/register/register_screen.dart';
import 'package:shop_app/screens/shopingCart/shoppingCart_screen.dart';
UserTokenController _controller = Get.put(UserTokenController());
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final formKey= GlobalKey<FormState>();
  String email= "";
  String pass= "";
    void _doSignIn (String email, String password) async {
    // await Future.delayed( Duration(milliseconds: 1000));
    showAlertDialog(context);
    var body = { "email" : email, "password" : password};
    var url = Uri.parse('http://192.168.0.104:4007/v1/login');
    var response = await http.post(url,
    body: json.encode(body), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200)
    { 
      var data = json.decode(response.body);
      if(TokenJSON.fromJson(data).code!=0){
        Fluttertoast.showToast(
        msg: TokenJSON.fromJson(data).message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
       );
       return;
      }
      _controller.updateToken(TokenJSON.fromJson(data).data.token);
      Fluttertoast.showToast(
      msg: "Đăng nhập thành công",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
      );
      Get.to(HomeScreen());
    }
    else {
      throw Exception("There is something wrong");  
    }
  }
  
  @override
  Widget build(BuildContext context) {
    bool ischeck;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 60.0,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String value){
                          return (value=="")?"Vui lòng nhập Email":null;
                        },
                        onSaved: (value){setState(() {
                          email=value;
                        });},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Mật khẩu',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                        validator: (String value){
                          return (value=="")?"Vui lòng nhập mật khẩu":null;
                        },
                        onSaved: (value){setState(() {
                          pass= value;
                        });},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              print('Forgotted Password!');
                            },
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: MaterialButton(
                      onPressed: (){
                        bool isValid = formKey.currentState.validate();
                        if(isValid)
                        {
                          formKey.currentState.save();
                          _doSignIn(email, pass);
                        }
                      },
                      color: Colors.blue,
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''Chưa có tài khoản? ''',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                         Get.to(RegisterPage());
                        },
                        child: Text('Đăng ký'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: new Row(
            children: [
               CircularProgressIndicator(),
               Container(margin: EdgeInsets.only(left: 5),child:Text("Vui lòng chờ trong giây lát..." )),
            ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }
}
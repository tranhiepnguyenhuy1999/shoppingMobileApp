
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/controller/userToken_controller.dart';
import 'package:shop_app/models/TokenJSON.dart';
import 'package:shop_app/screens/main/main_page.dart';

UserTokenController _controller = Get.put(UserTokenController());

class SignInScreen  extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey= GlobalKey<FormState>();

  final _passTextController = TextEditingController();
  final _emailTextController = TextEditingController();
    void _doSignIn (String email, String password) async {
    // await Future.delayed( Duration(milliseconds: 1000));
    var body = { "email" : email, "password" : password};
    var url = Uri.parse('http://192.168.2.8:4007/v1/login');
    var response = await http.post(url,
    body: json.encode(body), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200)
    { 
      var data = json.decode(response.body);
      _controller.updateToken(TokenJSON.fromJson(data).data.token);
      Get.to(MainPage());
    }
    else {
      throw Exception("There is something wrong");
    }
  }
  @override
  void dispose() {
    _passTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
            key: formKey,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildEmailTextFormField(),
                  SizedBox(height: 20.0,),
                  buildPassTextFormField(),
                  GestureDetector(
                    onTap: (){
                      bool isValid = formKey.currentState.validate();
                      if(isValid)
                      {
                        formKey.currentState.save();
                        _doSignIn(_emailTextController.text, _passTextController.text);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                    ),
                  )
                ],
          ),
            ),
        ),
    );
  }

  Widget buildEmailTextFormField() => TextFormField(
    controller: _emailTextController,
    decoration: const InputDecoration(
    icon: Icon(Icons.email),
    hintText: 'Email',
    labelText: 'Email *',
  ),
    validator: (String value){
      return (value=="")?"Vui lòng nhập Email":null;
    },
    onSaved: (value){setState(() {
      email: value;
    });},
  );

  Widget buildPassTextFormField() => TextFormField(
    controller: _passTextController,
    decoration: const InputDecoration(
    icon: Icon(Icons.password_sharp),
      hintText: 'Password',
      labelText: 'Password *',
    ),
    validator: (String value){
      return (value=="")?"Vui lòng nhập mật khẩu":null;
    },
    onSaved: (value){setState(() {
      password: value;
    });},
  );
}
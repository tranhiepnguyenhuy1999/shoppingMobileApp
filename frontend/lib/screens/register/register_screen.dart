import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop_app/screens/add_product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/author/signIn_screen.dart';
import 'package:shop_app/screens/main/main_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

closeKeyboard(BuildContext context) {
  var currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

class _RegisterPageState extends State<RegisterPage> {

  final _nameTextController = TextEditingController();
  bool _nameValidate = false;

  final _emailTextController = TextEditingController();
  bool _emailValidate = false;

  bool _isObscure0 = true;
  bool _isObscure1 = true;

  final _phoneTextController = TextEditingController();
  // var maskFormatter = new MaskTextInputFormatter(
  //     mask: '####-###-###', filter: {"#": RegExp(r'[0-9]')});
  bool _phoneValidate = false;

  // final _userNameTextController = TextEditingController();
  // bool _userNameValidate = false;

  final _passwordTextController = TextEditingController();
  bool _passwordValidate = false;

  final _prePasswordTextController = TextEditingController();
  bool _prePasswordValidate = false;
void _doSignUp (String email, String password, String name, String phone) async {
    // await Future.delayed( Duration(milliseconds: 1000));
    var body = { "email" : email, "password" : password, "name" : name, "phone" : phone};
    var url = Uri.parse('http://192.168.2.8:4007/v1/register');
    var response = await http.post(url,
    body: json.encode(body), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200)
    { 
      Get.to(SignInScreen());
    }
    else {
      throw Exception("There is something wrong");
    }
  }
  @override
  void dispose() {
    _nameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var outputFormat = DateFormat('yyyy-MM-dd');
    // var outputDate = outputFormat.format(_selectedDate);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        child: Icon(Icons.home),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "Đăng ký",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Image.asset(
                "assets/icons/account.png",
                height: 150,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                        controller: _nameTextController,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Họ và tên",
                          errorText:
                              _nameValidate ? 'Vui lòng nhập tên ' : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 14),
                        ),
                        onEditingComplete: () {
                          setState(() {
                            _nameTextController.text.isEmpty
                                ? _nameValidate = true
                                : _nameValidate = false;
                          });
                          if (_nameValidate != true) {
                            closeKeyboard(context);
                          }
                        },
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                        controller: _emailTextController,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Email",
                          errorText:
                              _emailValidate ? 'Vui lòng nhập email ' : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 14),
                        ),
                        onEditingComplete: () {
                          setState(() {
                            _emailTextController.text.isEmpty
                                ? _emailValidate = true
                                : _emailValidate = false;
                          });
                          if (_emailValidate != true) {
                            closeKeyboard(context);
                          }
                        },
                      ),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              //inputFormatters: [maskFormatter],
                              controller: _phoneTextController,
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                              onSubmitted: (v) {
                                FocusScope.of(context).nextFocus();
                              },

                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Số điện thoại",
                                errorText: _phoneValidate
                                    ? 'Vui lòng nhập số điện thoại '
                                    : null,
                                labelStyle: const TextStyle(
                                    color: Color(0xff888888), fontSize: 14),
                              ),
                              onEditingComplete: () {
                                setState(() {
                                  _phoneTextController.text.isEmpty
                                      ? _phoneValidate = true
                                      : _phoneValidate = false;
                                });
                                if (_phoneValidate != true) {
                                  closeKeyboard(context);
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                      // TextField(
                      //   textInputAction: TextInputAction.next,
                      //   onSubmitted: (v) {
                      //     FocusScope.of(context).nextFocus();
                      //   },
                      //   controller: _phoneTextController,
                      //   style: const TextStyle(fontSize: 18, color: Colors.black),
                      //   decoration: InputDecoration(
                      //     labelText: "Số điện thoại",
                      //     errorText:
                      //         _phoneValidate ? 'Vui lòng nhập số điện thoại ' : null,
                      //     labelStyle:
                      //         const TextStyle(color: Color(0xff888888), fontSize: 14),
                      //   ),
                      //   onEditingComplete: () {
                      //     setState(() {
                      //       _phoneTextController.text.isEmpty
                      //           ? _phoneValidate = true
                      //           : _phoneValidate = false;
                      //     });
                      //     if (_phoneValidate != true) {
                      //       closeKeyboard(context);
                      //     }
                      //   },
                      // ),

                      // TextField(
                      //   textInputAction: TextInputAction.next,
                      //   onSubmitted: (v) {
                      //     FocusScope.of(context).nextFocus();
                      //   },
                      //   controller: _userNameTextController,
                      //   style:
                      //       const TextStyle(fontSize: 18, color: Colors.black),
                      //   decoration: InputDecoration(
                      //     labelText: "Tên tài khoản",
                      //     errorText: _userNameValidate
                      //         ? 'Vui lòng nhập tên tài khoản '
                      //         : null,
                      //     labelStyle: const TextStyle(
                      //         color: Color(0xff888888), fontSize: 14),
                      //   ),
                      //   onEditingComplete: () {
                      //     setState(() {
                      //       _userNameTextController.text.isEmpty
                      //           ? _userNameValidate = true
                      //           : _userNameValidate = false;
                      //     });
                      //     if (_userNameValidate != true) {
                      //       closeKeyboard(context);
                      //     }
                      //   },
                      // ),

                      TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                        obscureText: _isObscure0,
                        controller: _passwordTextController,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure0
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure0 = !_isObscure0;
                              });
                            },
                          ),
                          errorText: _passwordValidate
                              ? 'Vui lòng nhập mật khẩu '
                              : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 14),
                        ),
                        onEditingComplete: () {
                          setState(() {
                            _passwordTextController.text.isEmpty
                                ? _passwordValidate = true
                                : _passwordValidate = false;
                          });
                          if (_passwordValidate != true) {
                            closeKeyboard(context);
                          }
                        },
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                        obscureText: _isObscure1,
                        controller: _prePasswordTextController,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Nhập lại mật khẩu",
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            },
                          ),
                          errorText: _prePasswordValidate
                              ? 'Vui lòng nhập mật khẩu '
                              : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 14),
                        ),
                        onEditingComplete: () {
                          setState(() {
                            _prePasswordTextController.text.isEmpty
                                ? _prePasswordValidate = true
                                : _prePasswordValidate = false;
                          });
                          if (_prePasswordValidate != true) {
                            closeKeyboard(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(180, 50), primary: Colors.blue),
                  onPressed: () {
                    if(!_nameValidate&&!_phoneValidate&&!_emailValidate&&!_passwordValidate)
                    {
                      print({ "email" :_emailTextController.text ,
    "password" : _passwordTextController.text,
    "name" : _nameTextController.text,
    "phone" : _phoneTextController.text});
                      print("SignUp");
                      _doSignUp(_emailTextController.text, _passwordTextController.text, _nameTextController.text, _phoneTextController.text);
                    }
                  },
                  child: Text("Đăng ký")),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

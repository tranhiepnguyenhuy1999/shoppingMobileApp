import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/author/login_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';

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
    showAlertDialog(context);
    var body = { "email" : email, "password" : password, "name" : name, "phone" : phone};
    var url = Uri.parse('http://192.168.0.104:4007/v1/register');
    try{
      await Future.delayed( Duration(milliseconds: 1000));
    var response = await http.post(url,
    body: json.encode(body), headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 30));
    if(response.statusCode == 200)
    { 
      var data = json.decode(response.body);
      print(data);
      Fluttertoast.showToast(
        msg: "????ng ki?? tha??nh c??ng, quay tr???? la??i trang ????ng nh????p",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
       );
    }
    else {
      throw Exception("There is something wrong");
    }
    }on TimeoutException catch (_) {
      print(_);
    } on SocketException catch (_) {
      // Other exception
    }
     Navigator.pop(context);
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60.0,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 45,
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
                          labelText: "H??? v?? t??n",
                          errorText:
                              _nameValidate ? 'Vui l??ng nh???p t??n ' : null,
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
                              _emailValidate ? 'Vui l??ng nh???p email ' : null,
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
                                labelText: "S??? ??i???n tho???i",
                                errorText: _phoneValidate
                                    ? 'Vui l??ng nh???p s??? ??i???n tho???i '
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
                          labelText: "M???t kh???u",
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
                              ? 'Vui l??ng nh???p m???t kh???u '
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
                          labelText: "Nh???p l???i m???t kh???u",
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
                              ? 'Vui l??ng nh???p m???t kh???u '
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
                           SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: MaterialButton(
                        onPressed: (){
                        if(!_nameValidate&&!_phoneValidate&&!_emailValidate&&!_passwordValidate)
                              {
                                _doSignUp(_emailTextController.text, _passwordTextController.text, _nameTextController.text, _phoneTextController.text);
                              }
                        },
                        color: Colors.blue,
                        child: Text(
                          '????ng k??',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                    ),
                  ),
                      ),
              const SizedBox(
                height: 15,
              ),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''Quay tr???? la??i trang''',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                         Get.to(LoginScreen());
                        },
                        child: Text('????ng nh????p'),
                      )
                    ],
                  ),
            ],
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
               Container(margin: EdgeInsets.only(left: 5),child:Text("Vui lo??ng ch???? trong gi??y la??t..." )),
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

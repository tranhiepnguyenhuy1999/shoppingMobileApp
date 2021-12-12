
import 'package:flutter/material.dart';

class SignInScreen  extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey= GlobalKey<FormState>();
  String phone;
  String password;

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
                  buildPhoneTextFormField(),
                  SizedBox(height: 20.0,),
                  buildPassTextFormField(),
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
                      child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                    ),
                  )
                ],
          ),
            ),
        ),
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

  Widget buildPassTextFormField() => TextFormField(
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
import 'package:get/get.dart';
class UserController extends GetxController {
    Object  user= {}.obs;
    
    updateUser (name, age) => {
      user ={name: name, age: age}
    };

    }
    
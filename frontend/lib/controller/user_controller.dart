import 'package:get/get.dart';
class UserController extends GetxController {
    Object  user= {}.obs;
    
    updateUser (name, age) => {
      user ={name: name, age: age}
    };

    }
    
    class User {
        String name;
        int age;

        User(String n, int age){
          this.name=n;
          this.age=age;
        }
    }
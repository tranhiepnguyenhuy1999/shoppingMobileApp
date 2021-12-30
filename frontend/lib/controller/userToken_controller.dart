import 'package:get/get.dart';
class UserTokenController extends GetxController {
    var userToken= "".obs;
    
    updateToken ( token) =>
    {
      userToken.value = token
    };
}
    
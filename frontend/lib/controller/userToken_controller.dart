import 'package:get/get.dart';

class UserTokenController extends GetxController {
    var userToken= "".obs;
    dynamic isLogin = false.obs;
    updateToken (token) =>
    {
      userToken.value = token,
      isLogin.value=true
    };
}
    
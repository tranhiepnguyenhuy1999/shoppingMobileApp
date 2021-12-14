import 'package:get/get.dart';
import 'package:shop_app/models/Product%20copy.dart';

class CartController extends GetxController{
  var product = [].obs;
  Function addCart(item){
    if(product.value.any((element) => element.id == item.id))
    {
      print(product);
      int index = product.value.indexWhere((ele)=> ele.id==item.id);
      product.value[index].amount++;
    }
    else
    {
      product.value.add(item);
    }
  }

  Function clearAll() {
    product.value.clear();
  }
}
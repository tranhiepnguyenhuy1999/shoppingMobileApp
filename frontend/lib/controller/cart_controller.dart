import 'package:get/get.dart';
import 'package:shop_app/models/Product%20copy.dart';

class CartController extends GetxController{
  var product = [].obs;
  var count= 0.obs;
  Function addCart(item){
    if(product.value.any((element) => element.id == item.id))
    {
      int index = product.value.indexWhere((ele)=> ele.id==item.id);
      product.value[index].amount++;
    }
    else
    {
      product.value.add(item);
    }
    product.refresh();
  }
  void changeAmountById(id, amount) {
    int index = product.value.indexWhere((ele)=> ele.id==id);
    product.value[index].amount= amount;
    product.refresh();
  }
  Function clearAll() {
    product.value.clear();
    product.refresh();
  }
}
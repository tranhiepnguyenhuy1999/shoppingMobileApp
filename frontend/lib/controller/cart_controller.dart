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
      count.value++;
    }
    else
    {
      product.value.add(item);
      count.value++;

    }
    product.refresh();
  }
  void changeAmountById(id, amount) {
    int index = product.value.indexWhere((ele)=> ele.id==id);
    product.value[index].amount= amount;
    count.value+=amount;

    product.refresh();
  }
  Function clearAll() {
    product.value.clear();
    count.value=0;
    product.refresh();
  }
}
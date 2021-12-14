import 'package:shop_app/models/Product.dart';

class CartItemM {
  String image, title;
  int price, size, id, amount;

  CartItemM({
    this.id,
    this.image,
    this.title,
    this.price,
    this.size,
    this.amount
  });

  CartItemM.fromProduct(Product product, int amount):
      id = product.id,
      image = product.image,
      title =product.title,
      price =product.price,
      size =product.size,
      amount =amount;

}
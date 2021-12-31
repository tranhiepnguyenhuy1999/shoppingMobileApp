class Bill {
  List<BillProduct> products;
  int totalPrice;
  String name;
  String phone;
  String address;

  Bill({this.products, this.totalPrice, this.name, this.phone, this.address}); 

  Bill.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<BillProduct>();
      json['products'].forEach((v) {
        products.add(new BillProduct.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class BillProduct {
  int productId;
  int quantity;

  BillProduct({this.productId, this.quantity});

  BillProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
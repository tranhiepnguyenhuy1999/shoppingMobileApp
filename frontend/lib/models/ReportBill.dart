class ReportBillJSON {
  int code;
  String message;
  Data data;

  ReportBillJSON({this.code, this.message, this.data});

  ReportBillJSON.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Order> orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Order>();
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  int userId;
  int totalPrice;
  Null couponCodeId;
  String name;
  String phone;
  int payPrice;
  String address;
  String status;
  String hash;
  String createdAt;
  List<Detail> details;

  Order(
      {this.id,
      this.userId,
      this.totalPrice,
      this.couponCodeId,
      this.name,
      this.phone,
      this.payPrice,
      this.address,
      this.status,
      this.hash,
      this.createdAt,
      this.details});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    couponCodeId = json['coupon_code_id'];
    name = json['name'];
    phone = json['phone'];
    payPrice = json['pay_price'];
    address = json['address'];
    status = json['status'];
    hash = json['hash'];
    createdAt = json['created_at'];
    if (json['details'] != null) {
      details = new List<Detail>();
      json['details'].forEach((v) {
        details.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_price'] = this.totalPrice;
    data['coupon_code_id'] = this.couponCodeId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['pay_price'] = this.payPrice;
    data['address'] = this.address;
    data['status'] = this.status;
    data['hash'] = this.hash;
    data['created_at'] = this.createdAt;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int id;
  int productId;
  int quantity;
  int unitPrice;
  int orderId;
  String createdAt;
  Product product;

  Detail(
      {this.id,
      this.productId,
      this.quantity,
      this.unitPrice,
      this.orderId,
      this.createdAt,
      this.product});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String title;
  int price;
  int size;
  String description;
  String image;
  String color;
  String address;
  String hash;
  String createdAt;
  int categoryId;

  Product(
      {this.id,
      this.title,
      this.price,
      this.size,
      this.description,
      this.image,
      this.color,
      this.address,
      this.hash,
      this.createdAt,
      this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    size = json['size'];
    description = json['description'];
    image = json['image'];
    color = json['color'];
    address = json['address'];
    hash = json['hash'];
    createdAt = json['created_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['size'] = this.size;
    data['description'] = this.description;
    data['image'] = this.image;
    data['color'] = this.color;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['created_at'] = this.createdAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}
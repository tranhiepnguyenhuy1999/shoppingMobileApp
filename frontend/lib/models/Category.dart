class CategoryJSON {
  int code;
  String message;
  Data data;

  CategoryJSON({this.code, this.message, this.data});

  CategoryJSON.fromJson(Map<String, dynamic> json) {
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
  List<ProductCategory> categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<ProductCategory>();
      json['categories'].forEach((v) {
        categories.add(new ProductCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategory {
  int id;
  String name;
  String createdAt;

  ProductCategory({this.id, this.name, this.createdAt});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    return data;
  }
}
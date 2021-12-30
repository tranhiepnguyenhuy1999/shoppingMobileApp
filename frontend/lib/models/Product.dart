import 'package:flutter/material.dart';
class Product {
  int id;
  String title;
  int price;
  int size;
  String description;
  String image;
  String address;

  Product(
      {this.id,
      this.title,
      this.price,
      this.size,
      this.description,
      this.image,
      this.address});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    size = json['size'];
    description = json['description'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['size'] = this.size;
    data['description'] = this.description;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}
// class Product {
//   final String image, title, description, address;
//   final int price, size, id;
//   final Color color;
//   Product({
//     this.id,
//     this.image,
//     this.title,
//     this.price,
//     this.description,
//     this.size,
//     this.color,
//     this.address
//   });
// }

// List<Product> products = [
//   Product(
//       id: 1,
//       title: "Quần áo thể thao nam",
//       price: 156000,
//       size: 12,
//       description: "Sản phẩm có chất liệu mềm mại co giãn tốt , thoáng mát... đường may tinh tế sắc sảo, chuẩn form. Có nguồn góc xuất xứ rõ ràng đảm bảo chất lượng",
//       image: "https://filebroker-s.slatic.net/S2416ac32985f469e83275ac92cfe36e24.jpg_200x200q90.jpg_.webp",
//       color: Color(0xFF3D82AE),
//       address: "Hồ Chí Minh"
//       ),
//   Product(
//       id: 2,
//       title: "Áo Gi Lê thu đông nam",
//       price: 161500,
//       size: 8,
//       description: dummyText,
//       image: "https://filebroker-s.slatic.net/Sedb95e40a9cd44bf802c77625a818854N.jpg_200x200q90.jpg_.webp",
//       color: Color(0xFFD3A984),
//       address: "Hà Nội"
//       ),
//   Product(
//       id: 3,
//       title: "Quần short jean",
//       price: 234,
//       size: 10,
//       description: dummyText,
//       image: "https://vn-live-05.slatic.net/p/94d95d1bb047e6e6db8638edbc84a0cd.jpg_200x200q90.jpg_.webp",
//       color: Color(0xFF989493),
//       address: "Hà Nội"
//       ),
//   Product(
//       id: 4,
//       title: "Áo hoodie Nam Nữ in hình trước ngực",
//       price: 234,
//       size: 11,
//       description: dummyText,
//       image: "https://vn-live-05.slatic.net/p/abb141cfb63352a690f8af8b65b9ede0.jpg_200x200q90.jpg_.webp",
//       address: "Hà Nội",
//       color: Color(0xFFE6B398)),
//   Product(
//       id: 5,
//       title: " Áo khoác Nam trùm đầu",
//       price: 200000,
//       size: 12,
//       description: dummyText,
//       image: "https://vn-live-05.slatic.net/p/2a8e7c3c123e9bdc80b081efbc8f1cbf.jpg_200x200q90.jpg_.webp",
//       color: Color(0xFFFB7883),
//       address: "Hồ Chí Minh"
//       ),
//   Product(
//     id: 6,
//     title: "Quần thể thao nỉ 3 sọc",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/8329852313f2db089fc68db4c9372e59.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 7,
//     title: "Áo thun tay dài UNISEX",
//     price: 105000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/919cb34939fab386bb8fab7f7ac5ad4e.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 8,
//     title: "Áo khoác dù Nam Unisex",
//     price: 300000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/1923ed63a7a8c7428cb17f4cc44e0a82.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 9,
//     title: "Áo khoác hoodie Loang Thun Nỉ",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/8329852313f2db089fc68db4c9372e59.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 10,
//     title: "Bộ quẩn áo thể thao",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/6debcc92a0f15c9f3ff1d34d4db8e4c8.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 11,
//     title: "Áo thun nữ bẹt",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/0cc3641bb5a16367278f82a7ffcbd157.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 12,
//     title: "Áo thun cổ lọ nữ",
//     price: 90000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/a1da4400bdd2ceaffcda1f342179e661.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 13,
//     title: "Áo sơ mi nữ",
//     price: 100000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/f53ebbf4b420143ef539773c2d55d1c4.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 14,
//     title: "Áo thun UNISEX",
//     price: 250000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/915d1d2aa94d9c17ff0134762f85997a.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 15,
//     title:"Áo thun tay dài",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/ac83dca4bd0a491297551a9956eb0db3.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 16,
//     title: "Áo thun kiểu nữ lệch vai",
//     price: 200000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/b128fc11c4cdf1c6b24cdd6e9b014668.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 17,
//     title: "Áo sơ mi lụa",
//     price: 125000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/bbe0eac4c1c6919fdad21ae9e33bc789.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 18,
//     title: "Kính mát nam E300",
//     price: 70000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/344314ebc2dac9ab0d625a8d7bb51358.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 19,
//     title: "Mắt kính thời gian GM",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/ff2b25273c4b5a83d49d7028e723ce44.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 20,
//     title: "Vòng cổ phi hành gia",
//     price: 30000,
//     size: 12,
//     description: dummyText,
//     image: "https://my-live-05.slatic.net/p/753b5381bec1a139abe282d163565890.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 21,
//     title: "Mặt dây chuyền GM",
//     price: 141000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/S510be211a16649b38b0278982d1f20fdZ.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 22,
//     title: "Dây chuyền thạch anh hồng",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/Sf70a47d4ceff4cf7a4e8d1a2739eeea6a.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 23,
//     title: "Thẻ quân bài",
//     price: 50000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/Sc1a74611af314ba1a234d4c3b952dee5t.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 24,
//     title: "Giày chạy bộ NIKE",
//     price: 1400000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/Sc50fcc6bc100429d90a7299eae6fe478j.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 25,
//     title: "Giày đá bóng",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/S2cc595f15748485a86f4f1d9e132c9b2E.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 26,
//     title: "Giày thể thoa nữ gam hồng",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://filebroker-s.slatic.net/Sd96c3bfb87394b9bb122b72a8bf0af40Y.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 27,
//     title: "Dép quai ngang chất liệu đặt",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/42c64e8324a6b4d72e46e8f5907bf3e2.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 28,
//     title: "Giày đá bóng chuyên dụng",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/945fd81a3eab84bc2dfe1597c207dffe.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
//   Product(
//     id: 29,
//     title: "Giày thể thao chuyển dụng",
//     price: 140000,
//     size: 12,
//     description: dummyText,
//     image: "https://vn-live-05.slatic.net/p/7ccd28920ca15d6a0d53bb59814a9a76.jpg_200x200q90.jpg_.webp",
//     color: Color(0xFFAEAEAE),
//     address: "Hồ Chí Minh"
//   ),
// ];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

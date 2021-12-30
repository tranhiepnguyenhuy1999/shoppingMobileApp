import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/ReportBill.dart';
import 'package:shop_app/screens/order/component/itemCard.dart';
import 'package:intl/date_symbol_data_local.dart';
final DateFormat formatter = DateFormat('yyyy-MM-dd vào lúc hh:mm');
var f = NumberFormat('###,###,000');
class OrderDetail extends StatelessWidget {
  final Order order;

  const OrderDetail({
    Key key,
    this.order
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(
            children: [
              Text("Thông tin đơn hàng #${order.id}", style: TextStyle(fontWeight: FontWeight.w500)),
              Expanded(child: Container()),
              Text("Trạng thái: ${order.status}", style: TextStyle(color: Colors.blue[600]))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Text("Ngày đặt hàng: ${formatter.format(DateTime.parse(order.createdAt))}"),
        ),
        order.details.length !=0
        ?
        Column(
          children: [
            for ( var i in order.details) ItemCard(item: i, press: () =>{})
          ],
        )
        :
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Giỏ hàng trống"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [ Text("Tổng cộng (${order.details.fold(0, (prev, element) => prev+ element.quantity)} sản phẩm):"),SizedBox(width: 10), Text("₫ ${f.format(order.payPrice)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),) ]),
        ),
        ],
      ),
    );
  }
}
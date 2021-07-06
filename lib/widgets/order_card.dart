import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class OrderCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final int cost;
  final String orderStatus;
  final String orderId;
  const OrderCardWidget({
    Key? key,
    required this.title,
    required this.cost,
    required this.date,
    required this.orderStatus,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            offset: Offset.zero,
            blurRadius: 1,
            spreadRadius: 0,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              date,
              style: TextStyle(
                color: AppColors.accentColor.withOpacity(0.60),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              "Order Id :  $orderId",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.60),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹$cost/-",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  orderStatus,
                  style: TextStyle(
                    color: orderStatus == "Delivered"
                        ? Color(0xFF10C600)
                        : orderStatus == "Pending"
                            ? Color(0xFFFF8413)
                            : Color(0xFFF74810),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/widgets/chip.dart';
import 'package:shopat/widgets/order_card.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'My Orders',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChipWidget(
                        chipText: "  All  ",
                        isActive: true,
                      ),
                      ChipWidget(
                        chipText: " Delivered ",
                        isActive: false,
                      ),
                      ChipWidget(
                        chipText: " Cancelled ",
                        isActive: false,
                      ),
                      ChipWidget(
                        chipText: " Pending ",
                        isActive: false,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  OrderCardWidget(
                    title: "Cotton Saree + 3 items",
                    cost: 6992,
                    date: "7 July 2021",
                    orderStatus: OrderStatus.Delivered,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  OrderCardWidget(
                    title: "Cotton Saree + 3 items",
                    cost: 6992,
                    date: "7 July 2021",
                    orderStatus: OrderStatus.Cancelled,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  OrderCardWidget(
                    title: "Cotton Saree + 3 items",
                    cost: 6992,
                    date: "7 July 2021",
                    orderStatus: OrderStatus.Pending,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

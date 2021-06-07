import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "1 ",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          "item",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.grey[700],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.grey),
                                  ListTile(
                                    title: Text(
                                      "Delivering to:",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Ram nagar extension\nSiraj colony, 2452255 Chattisgarh India",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.accentColor,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey),
                                  ListTile(
                                    title: Text(
                                      "Seller:",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Rajaji Clothing Centre, Sirah",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        width: 120.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: AppColors.accentColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Contact Seller",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          "Total: ",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          "₹ 500/-",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.grey[700],
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        width: 100.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: AppColors.accentColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                FlutterLogo(size: 80.0),
                                SizedBox(width: 20.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Flutter Logo",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      "This is official Flutter Logo",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14.0,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      "Size : 40",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14.0,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ 500/-",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(width: 36.0),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            width: 100.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: AppColors.highlighedColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 4.0);
                    },
                    itemCount: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

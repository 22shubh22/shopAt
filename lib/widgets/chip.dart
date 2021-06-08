import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class ChipWidget extends StatelessWidget {
  final String chipText;
  final bool isActive;
  const ChipWidget({Key? key, required this.chipText, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: isActive ? AppColors.secondaryColor : Color(0xFFA6A6A6),
        ),
        color: isActive
            ? AppColors.secondaryColor.withOpacity(0.30)
            : AppColors.diasbledColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          chipText,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            color: isActive
                ? AppColors.secondaryColor
                : AppColors.accentColor.withOpacity(0.60),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? trailingActionWidget;
  final String hint;

  const LoginTextField({
    Key? key,
    required this.controller,
    this.trailingActionWidget,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.accentColor.withOpacity(0.60),
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
          suffixIcon: trailingActionWidget,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: AppColors.accentColor.withOpacity(0.15),
              width: 0.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: AppColors.accentColor.withOpacity(0.15),
              width: 0.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: AppColors.accentColor.withOpacity(0.15),
              width: 0.2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: AppColors.accentColor.withOpacity(0.15),
              width: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

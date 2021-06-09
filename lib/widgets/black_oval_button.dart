import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class BlackOvalButton extends StatelessWidget {
  final Function onPressedAction;
  final Widget child;
  const BlackOvalButton({
    Key? key,
    required this.child,
    required this.onPressedAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: AppColors.accentColor,
        backgroundColor: AppColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      onPressed: () async {
        await onPressedAction();
      },
      child: child,
    );
  }
}

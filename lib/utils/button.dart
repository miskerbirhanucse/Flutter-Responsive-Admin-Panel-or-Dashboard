import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final GestureTapCallback? onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  const Button({
    super.key,
    required this.text,
    this.padding,
    this.onPressed,
    this.textStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? CustomColor.primaryColor,
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        child: Text(
          text,
          style: textStyle ??
              textHeader2.copyWith(
                color: CustomColor.whiteColor,
              ),
        ),
      ),
    );
  }
}

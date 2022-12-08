import 'package:admin/utils/style_constants.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.obscureText = false,
    required this.controller,
    this.showSuffixIcon = false,
    this.onPressedForPassword,
    this.isShowPassword,
  });

  final String title;
  final bool obscureText;
  final TextEditingController controller;
  final bool showSuffixIcon;
  final Function()? onPressedForPassword;
  final bool? isShowPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColor.accentWhite,
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF5F5F5),
                  hintText: title,
                  hintStyle: textDefault.copyWith(
                    color: const Color(0xff8E8E8E),
                  ),
                  border: InputBorder.none,
                  suffixIcon: showSuffixIcon
                      ? isShowPassword != null
                          ? IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                isShowPassword!
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: onPressedForPassword,
                            )
                          : null
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

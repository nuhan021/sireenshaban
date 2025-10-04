import 'package:flutter/material.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class IField extends StatelessWidget {
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.overrideValidator = false,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.hintTextStyle,
    this.skipValidator = false,
    super.key,
  });


  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintTextStyle;
  final bool skipValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: skipValidator? null : overrideValidator ? validator : (value) {
        if(value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: AppColors.primaryDeepBlueNormal,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryDeepBlueNormal,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryDeepBlueNormal,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: filled,
        fillColor: fillColour,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: hintTextStyle ?? TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
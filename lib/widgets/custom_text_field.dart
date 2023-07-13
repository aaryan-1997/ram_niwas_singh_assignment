import 'package:flutter/material.dart';

import '../config/dimensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.iconPrefix,
    this.iconColor = Colors.black,
    this.onSuffixTap,
    this.iconSuffix,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    this.onTap,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textCapital = TextCapitalization.words,
    required this.validator,
    this.fillColor = Colors.white,
  }) : super(key: key);

  final IconData? iconPrefix;
  final Color iconColor;
  final Color fillColor;
  final String? Function(String?)? validator;
  final void Function()? onSuffixTap;
  final IconData? iconSuffix;
  final String labelText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final int minLines;
  final TextCapitalization textCapital;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0),
        // border: Border.all(
        //   color: Colors.blackColor.withAlpha(100),
        //   width: 1.5,
        // ),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        autovalidateMode: AutovalidateMode.disabled,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: Dimensions.width10,
            top: Dimensions.height10,
            bottom: Dimensions.height10,
          ),
          //prefixIcon: Icon(iconPrefix, color: iconColor),
          suffixIcon: GestureDetector(
            onTap: onSuffixTap,
            child: Icon(
              iconSuffix,
              color: iconColor,
              size: Dimensions.iconSize24,
            ),
          ),
          hintText: labelText,
          labelText: labelText,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          errorStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.red,
            fontSize: Dimensions.font14,
          ),
          border: outlineInputBorder,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            fontSize: Dimensions.font14,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: Dimensions.font16,
          ),
        ),
        textInputAction: textInputAction,
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        textCapitalization: textCapital,
        validator: validator,
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black.withAlpha(100),
    width: 0,
  ),
  borderRadius: BorderRadius.circular(Dimensions.radius10),
);

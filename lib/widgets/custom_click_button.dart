import 'package:flutter/material.dart';

import '../config/dimensions.dart';
import 'small_text.dart';

class CustomClickButton extends StatelessWidget {
  const CustomClickButton(
      {Key? key,
      required this.title,
      this.onTap,
      this.titleSize = 20,
      this.titleColor = Colors.white,
      this.buttonColor = Colors.black})
      : super(key: key);
  final String title;
  final Color buttonColor;
  final Color titleColor;
  final double titleSize;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimensions.height15),
      splashColor: Colors.white.withAlpha(100),
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(Dimensions.height15),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: Dimensions.width10 * 1.26,
              top: Dimensions.width10 * 1.26),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(Dimensions.height15),
          ),
          child: SmallText(
            textAlign: TextAlign.center,
            text: title,
            size: titleSize,
            color: titleColor,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

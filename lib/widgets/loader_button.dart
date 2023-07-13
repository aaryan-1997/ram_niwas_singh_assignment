import 'package:flutter/material.dart';

import '../config/dimensions.dart';

class LoaderButton extends StatelessWidget {
  const LoaderButton({Key? key, this.buttonColor = Colors.teal})
      : super(key: key);
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.width10,
          top: Dimensions.width10),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      child: SizedBox(
        height: Dimensions.width30,
        width: Dimensions.width30,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}

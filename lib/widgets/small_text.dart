import 'package:flutter/material.dart';

import '../config/dimensions.dart';


class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double height;
  final int maxline;
  final TextAlign textAlign;
  final TextOverflow overFlow;
  final TextDecoration textDecoration;
  final FontWeight weight;
  const SmallText(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      this.size = 0,
      this.height = 1.2,
      this.maxline = 1,
      this.weight = FontWeight.w600,
      this.textAlign = TextAlign.start,
      this.textDecoration = TextDecoration.none,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontFamily: 'Roboto',
          fontWeight: weight,
          decoration: textDecoration,
          height: height),
      overflow: overFlow,
    );
  }
}

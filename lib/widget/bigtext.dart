import 'package:flutter/material.dart';
import 'package:mystore/utils/dimension.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({
    Key? key,
    this.color = const Color(0xff332d2b),
    this.size = 20,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: size == 0 ? Dimen.font20 : size,
        color: color,
        // fontWeight: FontWeight.w400,
      ),
    );
  }
}

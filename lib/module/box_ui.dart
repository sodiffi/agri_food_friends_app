import 'package:agri_food_freind/myData.dart';
import 'package:flutter/material.dart';

class Box {
  static const BorderRadius normamBorderRadius =
      BorderRadius.all(Radius.circular(30));

  static Widget boxHasRadius(
      {Color? color,
      double? height,
      double? width,
      Border? border,
      required Widget? child,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      List<BoxShadow>? boxShadow}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: normamBorderRadius,
        color: color ?? Colors.white,
        border: border,
        boxShadow: boxShadow,
      ),
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}

Widget ButtonItem(String title, Function() function) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: MyTheme.color),
      onPressed: function,
      child: Text(title));
}

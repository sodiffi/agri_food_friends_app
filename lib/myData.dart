import 'package:flutter/material.dart';

class MyTheme {
  static Color backgroudColor = const Color.fromARGB(255, 245, 249, 237);
  static Color lightColor = const Color.fromRGBO(216, 232, 216, 1);
  static Color color = const Color.fromRGBO(10, 112, 41, 1);
  static Color textColor = Color.fromARGB(255, 12, 64, 41);
  static Color gray = const Color.fromRGBO(192, 192, 192, 1);
  static Color yellow = const Color.fromRGBO(254, 209, 0, 1);
  static Color red = const Color.fromRGBO(239, 43, 43, 1);
  static Color green = const Color.fromRGBO(194, 216, 194, 1);
}

class TextType {
  static const int page = 1;
  static const int fun = 2;
  static const int sub = 3;
  static const int content = 4;
  static const int hint = 5;
}

Widget textWidget(
    {String text = "",
    int? type = TextType.content,
    Color? color = Colors.black,
    TextAlign? textAlign = TextAlign.left,
    bool fontWeight = false}) {
  switch (type) {
    //1:page大標 2:功能文字 3:小標 4:內文 5:提示文字
    case TextType.page:
      return Text(text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: textAlign);
    case TextType.fun:
      return Text(text,
          style: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: fontWeight ? FontWeight.bold : null),
          textAlign: textAlign);
    case TextType.sub:
      return Text(text,
          style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: fontWeight ? FontWeight.bold : null),
          textAlign: textAlign);
    case TextType.content:
      return Text(text,
          style: TextStyle(fontSize: 16, color: color), textAlign: textAlign);

    case TextType.hint:
      return Text(text,
          style: TextStyle(fontSize: 14, color: color), textAlign: textAlign);
    default:
      return Text(text,
          style: TextStyle(fontSize: 14, color: color), textAlign: textAlign);
  }
}

class Name {
  static String userName = "user_name";
}

class PageName {
  static String welcome = "welcome";
}

import 'package:agri_food_freind/history/camera.dart';
import 'package:agri_food_freind/myData.dart';
import 'package:agri_food_freind/post.dart';
import 'package:agri_food_freind/sign.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'welcome.dart';
import 'post.dart';

main() async {
  runApp(MyApp());
}

abstract class Main extends StatefulWidget {
  const Main({super.key});
  String get userName;
}

class MyApp extends StatefulWidget {
  // final String userName;
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() => MyappState();
}

class MyappState extends State<MyApp> {
  String userName = "11136000";

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      if (prefs.containsKey(Name.userName)) {
        userName = prefs.getString(Name.userName) ?? "";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: '食農好朋友',
      theme: ThemeData(),
      home: Container(
        color: const Color.fromARGB(255, 93, 22, 22),
        child: SafeArea(
          child: userName != ""
              ? Home(
                  userName: userName,
                )
              : const Welcome(),
        ),
      ),
      routes: <String, WidgetBuilder>{
        'welcome': (_) =>  Welcome(),
        'home': (_) => Home(userName: userName),
        'scan': (_) => Camera(userName: userName),
        'login': (_) => Login(),
        Post.routeName: (_) => Post(
              userName: userName,
            ),
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

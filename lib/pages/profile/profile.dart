import 'package:agri_food_freind/module/box_ui.dart';
import 'package:agri_food_freind/myData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class SubMenu {
  SubMenu({required this.title, this.function, required this.img, this.widget});
  final String title;
  final String img;
  Widget? widget;
  Function()? function;
}

class _ProfileState extends State<Profile> {
  List<Widget> intos() {
    List<Widget> result = [];
    List<SubMenu> subMenus = [
      SubMenu(
        title: "我的發文",
        img: "assets/icons/my_posts.png",
        function: () => null,
      ),
      SubMenu(
          title: "我的歷程紀錄",
          img: "assets/icons/my_events.png",
          function: () => null),
      SubMenu(
        title: "登出",
        img: "assets/icons/log_out.png",
        function: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.popAndPushNamed(context, "welcome");
        },
      )
    ];

    for (var element in subMenus) {
      result.add(Box.boxHasRadius(
        color: MyTheme.backgroudColor,
        margin: const EdgeInsets.all(10),
        border: Border.all(width: 1.5, color: MyTheme.green),
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: element.function,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: element.widget ??
                    Image.asset(
                      element.img,
                      scale: 6,
                    ),
              ),
              textWidget(
                  text: element.title,
                  type: TextType.sub,
                  color: MyTheme.textColor),
            ],
          ),
        ),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Image.asset(
                'assets/icons/edit.png',
                scale: 6,
              ),
            ),
          ),
          Column(
            children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/headshots/headshot1.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 2,
                                color: MyTheme.lightColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        textWidget(
                            text: '王小美',
                            type: TextType.fun,
                            color: MyTheme.textColor,
                            fontWeight: true),
                      ],
                    ),
                  )
                ] +
                intos(),
          ),
        ],
      ),
    );
  }
}

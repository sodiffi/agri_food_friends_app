import 'package:agri_food_freind/activity/activity.dart';
import 'package:agri_food_freind/event/event.dart';
import 'package:agri_food_freind/history/my_diary_screen.dart';
import 'package:agri_food_freind/pages/profile/profile.dart';
import 'package:agri_food_freind/post.dart';
import 'package:agri_food_freind/user/user.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_view.dart';
import 'module/tabIcon_data.dart';



class Home extends StatefulWidget {
  const Home({super.key, required this.userName});
  final String userName;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
      // color: Colors.white,
      );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
    tabBody = EventScreen(animationController: animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            tabBody,
            bottomBar(),
          ],
        ));
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.pushNamed(context, Post.routeName);
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      EventScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = HistoryScreen(
                    animationController: animationController,
                    userName: widget.userName,
                  );
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = Activity();
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =const Profile();
                });
              });
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.title = '',
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  String title;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/icons/story_.png',
      selectedImagePath: 'assets/icons/story.png',
      index: 0,
      title: '動態',
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/scan_qrcode_.png',
      selectedImagePath: 'assets/icons/scan_qrcode.png',
      index: 1,
      title: '掃描商品',
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/calendar_.png',
      selectedImagePath: 'assets/icons/calendar.png',
      index: 2,
      title: '食農活動',
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icons/user_.png',
      selectedImagePath: 'assets/icons/user.png',
      title: '帳戶',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}

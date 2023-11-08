import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:city_picker_from_map/city_picker_from_map.dart';

import '../myData.dart';

class User extends StatefulWidget {
  const User({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  State<User> createState() => _User();
}

class _User extends State<User> {
  City? selectedCity;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CityPickerMap(
          width: 500,
          height: 500,
          map: Maps.TAIWAN,
          onChanged: (city) {
            print(city!.title.toString());
            setState(() {
              
              selectedCity = city;
            });
          },
          actAsToggle: true,
          dotColor: Colors.black,
          selectedColor: Colors.lightBlueAccent,
          strokeColor: Colors.black,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: MyTheme.color),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                if (context.mounted) {
                  Navigator.popAndPushNamed(context, "welcome");
                }
              },
              child:const  Text("登出")),
        )
      ],
    );
  }
}

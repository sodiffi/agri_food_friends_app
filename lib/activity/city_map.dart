import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:city_picker_from_map/city_picker_from_map.dart';

import '../myData.dart';

// ignore: must_be_immutable
class CityMap extends StatefulWidget {
  CityMap({Key? key, this.animationController}) : super(key: key);
  String selectCity = "";
  final AnimationController? animationController;
  @override
  State<CityMap> createState() => _CityMap();
}

class _CityMap extends State<CityMap> {
  City? selectedCity;
  String selectCity = '';
  var cityMap = {
    "Keelung": "基隆",
    "Taipei": "台北",
    "New Taipei": "新北市",
    "Taoyuan": "桃園",
    "Hsinchu": "新竹",
    "Miaoli": "苗栗",
    "Taichung": "台中",
    "Changhua": "彰化",
    "Yunlin": "雲林",
    "Nantou": "南投",
    "Chiayi": "嘉義",
    "Tainan": "台南",
    "Kaohsiung": "高雄",
    "Pingtung": "屏東",
    "Yilan": "宜蘭",
    "Hualien": "花蓮",
    "Taitung": "台東",
    "Kinmen": "金門",
    "Penghu": "澎湖"
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [
          textWidget(
              text: selectCity == '' ? "全部區域" : selectCity,
              type: TextType.fun,
              color: MyTheme.color,
              fontWeight: true),
          const Padding(padding: EdgeInsets.all(5)),
          Expanded(
            child: CityPickerMap(
              map: Maps.TAIWAN,
              onChanged: (city) {
                // print(city?.title.toString());
                setState(() {
                  selectCity =
                      (city == null ? "" : cityMap[city.title.toString()])!;
                  widget.selectCity = (selectCity == "" ? "" : selectCity);

                  selectedCity = city;
                });
              },
              actAsToggle: true,
              dotColor: Colors.black,
              selectedColor: MyTheme.lightColor,
              strokeColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

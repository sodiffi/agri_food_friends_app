import 'package:agri_food_freind/module/box_ui.dart';
import 'package:agri_food_freind/module/cusbehiver.dart';
import 'package:agri_food_freind/activity/city_map.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../myData.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  CityMap cityMap = CityMap();
  String filterCity = '';
  List<dynamic> csvTable = [];
  List data = [];

  loadCSVFormAssets() async {
    final myData = await rootBundle.loadString("assets/data/event.csv");
    csvTable = const CsvToListConverter().convert(myData);
    setState(() {
      data = csvTable;
    });
  }

  filterEvent() {
    data = [];
    if (filterCity == '') {
      setState(() {
        data = csvTable;
      });
    } else {
      csvTable.forEach((event) {
        if (event[2].toString().contains(filterCity)) data.add(event);
      });
    }
    print("data = $data");
  }

  @override
  void initState() {
    loadCSVFormAssets();
    super.initState();
  }

  Widget eventBox(
    List data,
    BuildContext context,
  ) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      shadowColor: MyTheme.lightColor,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        splashColor: Colors.green.withAlpha(0),
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                  text: data[0],
                  type: TextType.sub,
                  color: MyTheme.textColor,
                  fontWeight: true),
              const Padding(padding: EdgeInsets.all(5)),
              textWidget(text: '日期：${data[1]}', type: TextType.hint),
              textWidget(text: '舉辦單位：${data[2]}', type: TextType.hint),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.backgroudColor,
      child: Column(
        children: [
          Container(
              height: 60,
              alignment: Alignment.center,
              child: textWidget(
                  text: '近期活動', type: TextType.page, color: MyTheme.color)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: MyTheme.color),
            child: Text(filterCity == '' ? "全部區域" : filterCity),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (contexnt) {
                    return AlertDialog(
                      content: cityMap,
                      actions: [
                        ButtonItem("取消", () {
                          Navigator.pop(context);
                        }),
                        ButtonItem("確定", () {
                          setState(() {
                            filterCity = cityMap.selectCity;
                          });
                          filterEvent();
                          Navigator.pop(context);
                        }),
                      ],
                    );
                  });
            },
          ),
          if (data.isNotEmpty)
            Expanded(
              child: ScrollConfiguration(
                behavior: CusBehavior(),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return eventBox(data[index], context);
                    }),
              ),
            ),
        ],
      ),
    );
  }

  // return Card(
  //   margin: EdgeInsets.all(10),
  //   elevation: 8,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)), //<--custom shape
  //   child: Column(
  //     children: <Widget>[
  //       const SizedBox(
  //         width: 300,
  //         height: 50,
  //         child: Text('A card that can be tapped'),
  //       ),
  //     ],
  //   ),
  // );

  // return Container(
  //   child: ListView(children: [
  //     Text(
  //       "食農相關活動",
  //       style: TextStyle(fontSize: 30),
  //     ),
  //     ElevatedButton(
  //         style: ElevatedButton.styleFrom(backgroundColor: MyTheme.color),
  //         onPressed: () {
  //           show(context);
  //         },
  //         child: Text("太康有機食農教育體驗"))
  //   ]),
  // );
}

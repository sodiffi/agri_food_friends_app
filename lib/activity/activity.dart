import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../myData.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List data = [];

  void show(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: Text("太康有機食農教育體驗"),
      content: Column(children: [
        Text("開始日 2022-11-19"),
        Text("結束日 2022-11-19"),
        Text("地點 736台南市柳營區義士路三段121號"),
        Text(
            "推動有機田區食農教育體驗活動，讓消費者及親子團體，在安全無農藥汙染的園區裡，能盡情地體驗有機栽培跟蔬果採收的樂趣，本年度以「好食趣」為活動主軸，當天活動除了有體驗種菜、採果、拔蘿蔔、捆稻草競賽及手作DIY等活動外，中午還能享用有機專區生產的農場餐食，另外凡參加本次體驗活動的民眾，皆能獲得\$100元蔬果兌換券，可兌換專區生產的等值有機蔬果或農產加工品，歡迎大家逗陣來食當季呷健康〜"),
      ]),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: MyTheme.color),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("確認"))
      ],
    );
    showDialog(context: context, builder: ((context) => dialog));
  }

  loadCSVFormAssets() async {
    final myData = await rootBundle.loadString("assets/data/event.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    setState(() {
      data = csvTable;
    });

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
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(0),
        onTap: () {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            children: [
              Text(data[0]),
              Text(data[1]),
              Text(data[2])
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Container(
        color: MyTheme.lightColor,
        child: Column(
          children: [
            Text('近期活動'),
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return eventBox(data[index], context);
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container();
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
}

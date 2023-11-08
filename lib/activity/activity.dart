import 'dart:developer';
import 'dart:io';

import 'package:agri_food_freind/module/cusbehiver.dart';
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

  loadCSVFormAssets() async {
    final myData = await rootBundle.loadString("assets/data/event.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
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
    if (data.isNotEmpty) {
      return Container(
        color: MyTheme.backgroudColor,
        child: Column(
          children: [
            Container(
                height: 60,
                alignment: Alignment.center,
                child: textWidget(
                    text: '近期活動', type: TextType.page, color: MyTheme.color)),
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
    } else {
      return Container(color: MyTheme.backgroudColor);
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

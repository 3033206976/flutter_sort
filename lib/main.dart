
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MaterialApp(
    home: RunApp(),
  ));
}

class RunApp extends StatefulWidget {
  const RunApp({Key? key}) : super(key: key);

  @override
  State<RunApp> createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  List<Map> listMap= [
    {"name": "张森", "F": 55, "latitude": 116.39692783355713, "longitude": 39.91799827426921, "startTimeUtc": 1657937120, "endTimeUTC": 1658282720, "L": 1},
    {"name": "甜甜", "F": 100, "latitude": 116.41096115112305, "longitude": 39.92352768829278, "startTimeUtc": 1682388320, "endTimeUTC": 1682820320, "L": 3},
    {"name": "夏天", "F": 32, "latitude": 116.37495517730713, "longitude": 39.91411425223576, "startTimeUtc": 1654049120, "endTimeUTC": 1654394720, "L": 10},
    {"name": "冬天", "F": 10, "latitude": 116.40031814575195, "longitude": 39.902131644000484, "startTimeUtc": 1666058960, "endTimeUTC": 1666231760, "L": 0},
    {"name": "偌大", "F": 167, "latitude": 116.38126373291016, "longitude": 39.82923623690916, "startTimeUtc": 1660745360, "endTimeUTC": 1669777760, "L": 0}
  ];


  @override
  void initState() {
    super.initState();
    getBackInformation();
  }

  void getBackInformation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    listMap.forEach((element) {
      double distance = Geolocator.distanceBetween(116.30682706832886, 40.15613868448505, element["latitude"], element["longitude"]);
      element["D"] = distance / 1000;

      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(element["startTimeUtc"] * 1000);
      var dys = startTime.difference(DateTime.now()).inDays;
      element["T"] = dys;

      var molecule = element["L"] + element["F"];
      double denominator = sqrt(pow(element["D"], 2) + pow(element["T"], 2));
      double a =  molecule / double.parse(denominator.toStringAsFixed(2));

      element["result"] = double.parse(a.toStringAsFixed(5));
    });
    listMap.sort((key1, key2) {
      return key1["result"].compareTo(key2["result"]);
    });
    print("    " + listMap.toString());

    print("改 ----------------------》" + listMap.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Demo",
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   child: Text("D的值为： ${listMap[0]["D"].toString()}",),
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(top: 15.0),
          //   child: Text("T的值为： ${listMap[1]["T"].toString()}"),
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(top: 15.0),
          //   child: Text("L的值为： ${listMap[0]["L"].toString()}"),
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(top: 15.0),
          //   child: Text("F的值为： ${listMap[0]["F"].toString()}"),
          // ),
          Expanded(child:
              ListView.builder(itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Column(
                    children: [
                      Text(
                        listMap[index]["name"],
                        style: TextStyle(
                            letterSpacing: 5.0,
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("D的值为： ${listMap[index]["D"].toString()} km",
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Text("T的值为： ${listMap[index]["T"].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Text("L的值为： ${listMap[index]["L"].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Text("F的值为： ${listMap[index]["F"].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Text("result结果的值为： ${listMap[index]["result"].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ],
                  )
                );
              },
                itemCount: listMap.length,
              )
          )
        ],
      ),
    );
  }
}

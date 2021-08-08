import 'package:covid_statistics/controller/covid_statistics_controller.dart';
import 'package:covid_statistics/src/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '코로나 통계',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: App(),
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
    );
  }
}

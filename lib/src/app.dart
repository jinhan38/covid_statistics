import 'package:covid_statistics/cavas/arrow_clip_path.dart';
import 'package:covid_statistics/components/bar_chart.dart';
import 'package:covid_statistics/components/covid_statistics_viewer.dart';
import 'package:covid_statistics/controller/covid_statistics_controller.dart';
import 'package:covid_statistics/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  late double headerTopZone;

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top; //상태바의 사이즈를 가져온다
    headerTopZone += AppBar().preferredSize.height; //앱바의 사이즈를 가져온댜

    Widget divider() {
      return Container(
        height: 60,
        child: VerticalDivider(
          color: Colors.grey.withOpacity(0.5),
        ),
      );
    }

    Widget _todayStatistics() {
      return Obx(
        () => Row(
          children: [
            Expanded(
              child: CovidStatisticsViewer(
                  title: "격리해제",
                  addedCount: controller.todayData.calcClearCnt,
                  totalCount: DataUtils.simpleFormatStringToDouble(
                      controller.todayData.clearCnt),
                  upDown: controller
                      .calculateUpDown(controller.todayData.calcClearCnt),
                  dense: true),
            ),
            divider(),
            Expanded(
              child: CovidStatisticsViewer(
                  title: "검사중",
                  addedCount: controller.todayData.calcExamCnt,
                  totalCount: DataUtils.simpleFormatStringToDouble(
                      controller.todayData.examCnt),
                  upDown: controller
                      .calculateUpDown(controller.todayData.calcExamCnt),
                  dense: true),
            ),
            divider(),
            Expanded(
              child: CovidStatisticsViewer(
                  title: "사망자",
                  addedCount: controller.todayData.calcDeathCnt,
                  totalCount: DataUtils.simpleFormatStringToDouble(
                      controller.todayData.deathCnt),
                  upDown: controller
                      .calculateUpDown(controller.todayData.calcDeathCnt),
                  dense: true),
            ),
          ],
        ),
      );
    }

    Widget _covidTrendsChart() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "확진자 추이",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Obx(
                () => controller.weekData.length == 0
                    ? Container()
                    : CovidBarChart(
                        covidDates: controller.weekData,
                        maxY: controller.maxDecideValue),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("코로나 일별 현황", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.notifications, color: Colors.white),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true, //앱바의 영역을 body가 침범할 수 있도록 세팅
      body: Stack(children: [
        ..._background(),
        Positioned(
          top: headerTopZone + 200,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    _todayStatistics(),
                    SizedBox(height: 20),
                    _covidTrendsChart(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "$title : ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }

  List<Widget> _background() {
    return [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
              Color(0xff3c727c),
              // Color(0xff3c727c),
              Color(0xff33656e),
            ])),
      ),
      Positioned(
        left: -50,
        top: headerTopZone + 50,
        child: Container(
          child: Image.asset("assets/virus.png", width: Get.size.width * 0.5),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        top: headerTopZone + 10,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff195f68)),
            child: Obx(
              () => Text(
                controller.todayData.standardDayString,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 30,
        child: Obx(
          () => CovidStatisticsViewer(
              title: "확진자",
              addedCount: controller.todayData.calcDecideCnt,
              totalCount: DataUtils.simpleFormatStringToDouble(
                  controller.todayData.decideCnt),
              upDown: controller
                  .calculateUpDown(controller.todayData.calcDecideCnt),
              titleColor: Colors.white,
              subValueColor: Colors.white),
        ),
      ),
    ];
  }
}

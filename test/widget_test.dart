// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:covid_statistics/main.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>1.7898020411</accDefRate>
                <accExamCnt>11908436</accExamCnt>
                <accExamCompCnt>11492947</accExamCompCnt>
                <careCnt>22873</careCnt>
                <clearCnt>180719</clearCnt>
                <createDt>2021-08-05 09:50:52.915</createDt>
                <deathCnt>2109</deathCnt>
                <decideCnt>205701</decideCnt>
                <examCnt>415489</examCnt>
                <resutlNegCnt>11287246</resutlNegCnt>
                <seq>594</seq>
                <stateDt>20210805</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-08-07 10:19:32.221</updateDt>
            </item>
            <item>
                <accDefRate>1.7784726028</accDefRate>
                <accExamCnt>11864245</accExamCnt>
                <accExamCompCnt>11466356</accExamCompCnt>
                <careCnt>22697</careCnt>
                <clearCnt>179123</clearCnt>
                <createDt>2021-08-04 09:49:14.864</createDt>
                <deathCnt>2106</deathCnt>
                <decideCnt>203926</decideCnt>
                <examCnt>397889</examCnt>
                <resutlNegCnt>11262430</resutlNegCnt>
                <seq>593</seq>
                <stateDt>20210804</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accDefRate>1.7703206768</accDefRate>
                <accExamCnt>11820016</accExamCnt>
                <accExamCompCnt>11421716</accExamCompCnt>
                <careCnt>22188</careCnt>
                <clearCnt>177909</clearCnt>
                <createDt>2021-08-03 09:38:51.531</createDt>
                <deathCnt>2104</deathCnt>
                <decideCnt>202201</decideCnt>
                <examCnt>398300</examCnt>
                <resutlNegCnt>11219515</resutlNegCnt>
                <seq>592</seq>
                <stateDt>20210803</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-08-04 09:58:25.377</updateDt>
            </item>
            <item>
                <accDefRate>1.7654223809</accDefRate>
                <accExamCnt>11772604</accExamCnt>
                <accExamCompCnt>11385434</accExamCompCnt>
                <careCnt>22297</careCnt>
                <clearCnt>176605</clearCnt>
                <createDt>2021-08-02 09:37:51.966</createDt>
                <deathCnt>2099</deathCnt>
                <decideCnt>201001</decideCnt>
                <examCnt>387170</examCnt>
                <resutlNegCnt>11184433</resutlNegCnt>
                <seq>591</seq>
                <stateDt>20210802</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-08-03 11:08:09.679</updateDt>
            </item>
            <item>
                <accDefRate>1.7566148154</accDefRate>
                <accExamCnt>11751782</accExamCnt>
                <accExamCompCnt>11373182</accExamCompCnt>
                <careCnt>22011</careCnt>
                <clearCnt>175674</clearCnt>
                <createDt>2021-08-01 09:38:06.089</createDt>
                <deathCnt>2098</deathCnt>
                <decideCnt>199783</decideCnt>
                <examCnt>378600</examCnt>
                <resutlNegCnt>11173399</resutlNegCnt>
                <seq>590</seq>
                <stateDt>20210801</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-08-02 14:36:31.883</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>5</totalCount>
    </body>
</response>''';

  test("코로나 통계 테스트", () {

    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    var covid19Statics = <Covid19StatisticsModel>[];

    items.forEach((element) {
      covid19Statics.add(Covid19StatisticsModel.fromXml(element));
    });
    covid19Statics.forEach((covid19) {
      print("기준일 : ${covid19.stateDt}, 확진자수 : ${covid19.decideCnt}");
    });
  });
}

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel(
      {this.accDefRate,
      this.accExamCnt,
      this.accExamCompCnt,
      this.careCnt,
      this.clearCnt,
      this.createDt,
      this.deathCnt,
      this.decideCnt,
      this.examCnt,
      this.resutlNegCnt,
      this.seq,
      this.stateDt,
      this.stateTime,
      this.updateDt});

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResult(xml, "accDefRate"),
      accExamCnt: XmlUtils.searchResult(xml, "accExamCnt"),
      accExamCompCnt: XmlUtils.searchResult(xml, "accExamCompCnt"),
      careCnt: XmlUtils.searchResult(xml, "careCnt"),
      clearCnt: XmlUtils.searchResult(xml, "clearCnt"),
      createDt: XmlUtils.searchResult(xml, "createDt"),
      deathCnt: XmlUtils.searchResult(xml, "deathCnt"),
      decideCnt: XmlUtils.searchResult(xml, "decideCnt"),
      examCnt: XmlUtils.searchResult(xml, "examCnt"),
      resutlNegCnt: XmlUtils.searchResult(xml, "resutlNegCnt"),
      seq: XmlUtils.searchResult(xml, "seq"),
      stateDt: XmlUtils.searchResult(xml, "stateDt"),
      stateTime: XmlUtils.searchResult(xml, "stateTime"),
      updateDt: XmlUtils.searchResult(xml, "updateDt"),
    );
  }
}

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).first.isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
}

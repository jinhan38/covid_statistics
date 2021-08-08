import 'package:covid_statistics/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  String covidUrl =
      "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=FMdeBTwXrIXJqIqhl%2BnOMjEj0mKsTW9ao%2BIbQmICQRSlI5q9zGZEbC0Zr%2FyLp%2Fb5SYR7BaFe7yj9iqSD3a6uNw%3D%3D";

  late var dio = Dio();
  var startDate = "";
  var endDate = "";

  CovidStatisticsRepository() {
    dio = Dio();
  }

  Future<List<Covid19StatisticsModel>> fetchCovidStatistics(
      {String? startDate, String? endDate}) async {
    var query = Map<String, String>();
    if (startDate != null) query.putIfAbsent("startCreateDt", () => startDate);
    if (endDate != null) query.putIfAbsent("endCreateDt", () => endDate);
    var response = await dio.get(covidUrl, queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return results
          .map<Covid19StatisticsModel>(
              (element) => Covid19StatisticsModel.fromXml(element))
          .toList();
    } else {
      return Future.value(<Covid19StatisticsModel>[]);
    }
  }

}

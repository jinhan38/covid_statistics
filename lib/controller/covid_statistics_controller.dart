import 'package:covid_statistics/cavas/arrow_clip_path.dart';
import 'package:covid_statistics/model/covid_statistics.dart';
import 'package:covid_statistics/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDates = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovidStatistics(
        startDate: startDate, endDate: endDate);

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if (maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
    }
    _weekDates.addAll(result.sublist(0, result.length-1).reversed);
    _todayData(_weekDates.last);
  }

  Covid19StatisticsModel get todayData => _todayData.value;

  List<Covid19StatisticsModel> get weekData => _weekDates.value;

  ArrowDirection calculateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.MIDDEL;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}

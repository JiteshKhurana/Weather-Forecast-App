import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/daily_forecast_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import '../services/weather.dart';

class CardItem {
  late String day;
  late String date;
  late int temperature;
  late Image assetImage;
  CardItem(
      {required this.day,
      required this.date,
      required this.temperature,
      required this.assetImage});
}

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key, required this.locationWeather, this.cityName})
      : super(key: key);
  final dynamic locationWeather;
  final dynamic cityName;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late Widget weatherIcon;
  late String cityName;
  List<double> forecastDailyTemp = [];
  List<int> forecastDailyTime = [];
  List<int> forecastDailyWeatherIcon = [];
  List<CardItem> items = [];

  int i = 1;
  void forecastDailyTempAdd(dynamic weatherData) {
    if (i <= 7) {
      forecastDailyTemp.add(weatherData['daily'][i]['temp']['day']);
      i++;
      forecastDailyTempAdd(widget.locationWeather);
    }
  }

  int l = 1;
  void forecastDailyTimeAdd(dynamic weatherData) {
    if (l <= 7) {
      forecastDailyTime.add(weatherData['daily'][l]['dt']);
      l++;
      forecastDailyTimeAdd(widget.locationWeather);
    }
  }

  void cardItemAdd(int j) {
    if (j <= 6) {
      items.add(
        CardItem(
          day: tellMeTheDay(j),
          date: tellMeTheDate(j),
          temperature: forecastDailyTemp[j].toInt(),
          assetImage: weather.getWeatherIcon(forecastDailyWeatherIcon[j], 70),
        ),
      );
      j++;
      cardItemAdd(j);
    }
  }

  void updateUI(dynamic weatherData, dynamic cityNameData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          cityName = '';
          return;
        }
        double temp = weatherData['current']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['current']['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition, 200);
        cityName = cityNameData['name'];
      },
    );
  }

  String tellMeTheDate(int i) {
    int millis = forecastDailyTime[i];
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
    return DateFormat('MMMM,dd').format(dt);
  }

  String tellMeTheDay(int i) {
    int millis = forecastDailyTime[i];
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
    return DateFormat('E').format(dt);
  }

  int a = 1;
  void forecastDailyWeatherIconAdd(dynamic weatherData) {
    if (a <= 7) {
      forecastDailyWeatherIcon.add(weatherData['daily'][a]['weather'][0]['id']);
      a++;
      forecastDailyWeatherIconAdd(widget.locationWeather);
    }
  }

  @override
  void initState() {
    updateUI(widget.locationWeather, widget.cityName);
    forecastDailyTempAdd(widget.locationWeather);
    forecastDailyTimeAdd(widget.locationWeather);
    forecastDailyWeatherIconAdd(widget.locationWeather);
    cardItemAdd(0);
    super.initState();
  }

  Widget buildCard({required CardItem item}) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const DailyForecastScreen();
              },
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          height: 110,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: kSecondaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.day, style: kValueOfTempWindHumidity),
                  Text(
                    item.date,
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                '${item.temperature}°ᶜ',
                style: const TextStyle(fontSize: 55, color: Colors.white),
              ),
              item.assetImage,
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          "Forecast Report",
          style: kValueOfTempWindHumidity,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 25, left: 15),
              child: Text(
                'Next forecast',
                style: kValueOfTempWindHumidity,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) => buildCard(item: items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

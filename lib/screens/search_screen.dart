import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.locationWeather}) : super(key: key);
  final dynamic locationWeather;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String cityName;
  goToHomeScreen(String cityName) async {
    var weatherData = await WeatherModel().getCityWeather(cityName);
    var aQI = await WeatherModel().getAQICurrentLocation();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(
            locationWeather: weatherData,
            aQI: aQI,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Pick location',
                textAlign: TextAlign.center,
                style: kTitle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                'Find the area or city that you want to know\nthe detailed weather into at this time',
                style: kSmallText,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 55,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 150),
              height: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: kPrimaryColorLight,
              ),
              child: TextButton(
                onPressed: () {
                  goToHomeScreen(cityName);
                },
                child: Image.asset(
                  'icons/check-mark.png',
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// if (typedName != null) {
// var weatherData = await weather.getCityWeather(typedName);
// updateUI(weatherData);

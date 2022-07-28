import 'package:flutter/material.dart';
import 'package:weather_app/screens/welcome_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToWelcomeScreen();
    super.initState();
  }

  goToWelcomeScreen() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var aQI = await WeatherModel().getAQICurrentLocation();
    var cityName = await WeatherModel().getCurrentCityNameFromCoordinates();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WelcomeScreen(
              locationWeather: weatherData, aQI: aQI, cityName: cityName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Image.asset(
          'images/app_logo.png',
          height: 110,
        ),
      ),
    );
  }
}

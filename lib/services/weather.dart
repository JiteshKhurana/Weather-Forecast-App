import 'package:flutter/material.dart';
import 'location.dart';
import 'networking.dart';

const apiKey = 'eb9b91e6c25fd6f1fe0744bb59316d8e';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCurrentCityNameFromCoordinates() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var cityName = await networkHelper.getData();
    return cityName;
  }

  Future<dynamic> getAQICurrentLocation() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.waqi.info/feed/here/?token=18efe65c10b57597c3a29bcaf93ff42971fc6c78');
    var aQI = await networkHelper.getData();

    return aQI;
  }

  Image getWeatherIcon(int condition, double height) {
    if (condition > 200 && condition <= 232) {
      return Image.asset('icons/28.png', height: height);
    } else if (condition > 300 && condition <= 321) {
      return Image.asset('icons/22.png', height: height);
    } else if (condition > 500 && condition <= 504) {
      return Image.asset('icons/8.png', height: height);
    } else if (condition > 511 && condition <= 531) {
      return Image.asset('icons/22.png', height: height);
    } else if (condition > 600 && condition < 622) {
      return Image.asset('icons/18.png', height: height);
    } else if (condition > 701 && condition <= 781) {
      return Image.asset('icons/4.png', height: height);
    } else if (condition == 800) {
      return Image.asset('icons/26.png', height: height);
    } else if (condition == 801) {
      return Image.asset('icons/27.png', height: height);
    } else if (condition == 802) {
      return Image.asset('icons/35.png', height: height - 12);
    } else if (condition == 803) {
      return Image.asset('icons/35.png', height: height - 12);
    } else if (condition == 804) {
      return Image.asset('icons/35.png', height: height - 12);
    } else {
      return Image.asset('icons/32.png', height: height);
    }
  }

  IconData getUVIndexIcon(int uV) {
    if (uV >= 0 && uV <= 2) {
      return Icons.mood;
    } else if (uV >= 3 && uV <= 5) {
      return Icons.sentiment_satisfied;
    } else if (uV >= 6 && uV <= 7) {
      return Icons.sentiment_neutral;
    } else if (uV >= 8 && uV <= 10) {
      return Icons.sentiment_dissatisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  Color getUVIndexIconColor(int uV) {
    if (uV >= 0 && uV <= 2) {
      return Colors.green;
    } else if (uV >= 3 && uV <= 5) {
      return Colors.yellow;
    } else if (uV >= 6 && uV <= 7) {
      return Colors.orange;
    } else if (uV >= 8 && uV <= 10) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  String getUVIndexDescription(int uV) {
    if (uV >= 0 && uV <= 2) {
      return 'Low';
    } else if (uV >= 3 && uV <= 5) {
      return 'Moderate';
    } else if (uV >= 6 && uV <= 7) {
      return 'High';
    } else if (uV >= 8 && uV <= 10) {
      return 'Very High';
    } else {
      return 'Extreme';
    }
  }

  String getAirQualityDescription(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return 'Good';
    } else if (aqi >= 51 && aqi <= 100) {
      return 'Moderate';
    } else if (aqi >= 101 && aqi <= 150) {
      return 'Poor';
    } else if (aqi >= 151 && aqi <= 200) {
      return 'Unhealthy';
    } else if (aqi >= 201 && aqi <= 300) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  Color getAirQualityDescriptionColor(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return Colors.green;
    } else if (aqi >= 51 && aqi <= 100) {
      return Colors.yellow;
    } else if (aqi >= 101 && aqi <= 150) {
      return Colors.orange;
    } else if (aqi >= 151 && aqi <= 200) {
      return Colors.red;
    } else if (aqi >= 201 && aqi <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }
}

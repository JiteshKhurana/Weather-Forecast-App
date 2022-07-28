import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utilities/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen(
      {Key? key,
      required this.locationWeather,
      required this.aQI,
      required this.cityName})
      : super(key: key);
  final dynamic locationWeather;
  final dynamic aQI;
  final dynamic cityName;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset(
                'images/welcome_screen_pic.png',
                height: 250,
              ),
              const SizedBox(
                height: 120,
              ),
              // ignore: prefer_const_constructors
              Text(
                'Discover the Weather\nin Your City',
                textAlign: TextAlign.center,
                style: kWelcomeScreenTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: prefer_const_constructors
              Text(
                textAlign: TextAlign.center,
                'Get to know your weather maps and\nradar precipitation forecast',
                style: kWelcomeScreenTagLine,
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen(
                              locationWeather: widget.locationWeather,
                              aQI: widget.aQI,
                              cityName: widget.cityName);
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                        color: kYellowcolor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Center(
                      child: Text(
                        'Get Started',
                        style: kWelcomeScreenButton,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF090D3C);
const kPrimaryColorLight = Color(0xFF23214B);
const kSecondaryColor = Color(0xFF23214B);
const kYellowcolor = Color(0xFFFED058);

const kWelcomeScreenTitle =
    TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white);
const kForecastTime = TextStyle(fontSize: 20, color: Colors.white70);
const kWelcomeScreenTagLine = TextStyle(fontSize: 20, color: Colors.white);
const kWelcomeScreenButton = TextStyle(fontSize: 20, color: Color(0xFF090D3C));
const kTitle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);
const kAirQualitySuggestion = TextStyle(fontSize: 15, color: Colors.grey);

const kTempTextStyle = TextStyle(
  fontSize: 100.0,
  color: Colors.white,
);
const kDescription = TextStyle(
  fontSize: 42.0,
);
const kSmallText =
    TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w500);
const kAirQuality = TextStyle(fontSize: 18, color: Colors.grey);
TextStyle kAirQualityGases(ColorAir) {
  return TextStyle(
    fontSize: 20,
    color: ColorAir,
  );
}

const kForecastAirQuality = TextStyle(fontSize: 20, color: Colors.white);
const kAirQualityHelp = TextStyle(fontSize: 15, color: Colors.white);
const kToday = TextStyle(fontSize: 25, color: kYellowcolor);
const knext7days = TextStyle(fontSize: 20, color: Colors.white);
const kValueOfTempWindHumidity =
    TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500);

Widget kVerticalSpace(int height) {
  return SizedBox(
    height: height.toDouble(),
  );
}

const kTextFieldInputDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.search,
    color: Colors.white,
    size: 23,
  ),
  filled: true,
  fillColor: kPrimaryColorLight,
  hintText: 'Enter location',
  hintStyle: TextStyle(color: Colors.white),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);

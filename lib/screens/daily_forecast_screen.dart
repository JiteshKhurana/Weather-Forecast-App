import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/utilities/constants.dart';

import '../utilities/cardReusable.dart';
import '../utilities/daily_forecast_card.dart';

class DailyForecastScreen extends StatefulWidget {
  const DailyForecastScreen({Key? key}) : super(key: key);

  @override
  State<DailyForecastScreen> createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          "Daily Details",
          style: kValueOfTempWindHumidity,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              kVerticalSpace(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  DateFormat('EEEE').format(DateTime.now()),
                  style: kForecastAirQuality,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                  style: kSmallText,
                ),
              ),
              kVerticalSpace(20),
              ReusableCard(
                height: 400,
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'icons/22.png',
                          height: 60,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          '34 C',
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        )
                      ],
                    ),
                    kVerticalSpace(10),
                    Center(
                      child: GradientText(
                        'Moderate Rain',
                        // description.toTitleCase(),
                        style: kSmallText,
                        colors: const [
                          Colors.grey,
                          Colors.white,
                        ],
                      ),
                    ),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.device_thermostat,
                        text: 'Feels like',
                        value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.air, text: 'Wind', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.opacity, text: 'Humidity', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.sunny, text: 'UV Index', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.umbrella, text: 'Precipitation', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.compress, text: 'Pressure', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.visibility, text: 'Visibility', value: 44),
                    kVerticalSpace(10),
                    const DailyForecastCard(
                        icon: Icons.cloud, text: 'Cloud Cover', value: 44),
                  ],
                ),
              ),
              ReusableCard(
                height: 170,
                cardChild: Column(
                  children: [
                    const Text(
                      'Sun and Moon',
                      style: kForecastAirQuality,
                    ),
                    kVerticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                         Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                         Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    kVerticalSpace(15),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Rise',
                                style: kForecastAirQuality,
                              ),
                              Text(
                                'Set',
                                style: kForecastAirQuality,
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                '05:36',
                                style: kForecastAirQuality,
                              ),
                              Text(
                                '05:36',
                                style: kForecastAirQuality,
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Rise',
                                style: kForecastAirQuality,
                              ),
                              Text(
                                'Set',
                                style: kForecastAirQuality,
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                '05:36',
                                style: kForecastAirQuality,
                              ),
                              Text(
                                '05:36',
                                style: kForecastAirQuality,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

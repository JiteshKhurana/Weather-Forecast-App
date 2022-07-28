import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';

class AirQuality extends StatefulWidget {
  const AirQuality({
    Key? key,
    required this.aqi,
    required this.pM2_5,
    required this.sO2,
    required this.nO2,
    required this.o3,
    required this.cO,
    required this.cityName,
  }) : super(key: key);

  final dynamic aqi;
  final dynamic pM2_5;
  final dynamic sO2;
  final dynamic nO2;
  final dynamic o3;
  final dynamic cO;
  final dynamic cityName;

  @override
  State<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  WeatherModel weather = WeatherModel();
  late String descriptionAirQuality =
      weather.getAirQualityDescription(widget.aqi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          "Air Quality",
          style: kValueOfTempWindHumidity,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              backgroundColor: kPrimaryColor,
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              150.0, 20.0, 150.0, 30.0),
                          child: Container(
                            height: 3.0,
                            width: 60.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Air Quality',
                          style: kValueOfTempWindHumidity,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Our current air quality index (AQI) provides information on the quality of air that you are breathing and its impact on your health. There are at least 5 different pollutants that we track that impact the cleanliness of air and your health.',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        kVerticalSpace(20),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Good (0 to 50)',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Air quality is considered satisfactory, and air pollution poses little or no risk',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                            'You are good to go, enjoy your normal outdoor activities.',
                            style: kAirQualitySuggestion),
                        kVerticalSpace(20),
                        const Text(
                          'Moderate (51 to 100)',
                          style: TextStyle(fontSize: 20, color: Colors.yellow),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.',
                          style: kAirQualitySuggestion,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Poor (101 to 150)',
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Members of sensitive groups may experience health effects. The general public is not likely to be affected.',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.',
                          style: kAirQualitySuggestion,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Unhealthy (151 to 200)',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Active children and adults, and people with respiratory disease, such as asthma, should avoid prolonged outdoor exertion; everyone else, especially children, should limit prolonged outdoor exertion',
                          style: kAirQualitySuggestion,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Very Unhealthy (201 to 300)',
                          style: TextStyle(fontSize: 20, color: Colors.purple),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Health warnings of emergency conditions. The entire population is more likely to be affected.',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Active children and adults, and people with respiratory disease, such as asthma, should avoid all outdoor exertion; everyone else, especially children, should limit outdoor exertion.',
                          style: kAirQualitySuggestion,
                        ),
                        kVerticalSpace(20),
                        const Text(
                          'Hazardous (300 or Higher)',
                          style: TextStyle(fontSize: 20, color: Colors.brown),
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Health alert: everyone may experience more serious health effects',
                          style: kAirQualityHelp,
                        ),
                        kVerticalSpace(10),
                        const Text(
                          'Everyone should avoid all outdoor exertion',
                          style: kAirQualitySuggestion,
                        ),
                        kVerticalSpace(20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            kVerticalSpace(15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kSecondaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Air Quality Index',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  kVerticalSpace(5),
                  Text('${widget.cityName}', style: kSmallText),
                  kVerticalSpace(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${widget.aqi}',
                        style: TextStyle(
                            fontSize: 80,
                            color: weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        descriptionAirQuality,
                        style: TextStyle(
                            fontSize: 30,
                            color: weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                      ),
                    ],
                  ),
                  kVerticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.pM2_5.toStringAsFixed(1),
                            style: kAirQualityGases(weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                          ),
                          const Text('PM2.5', style: kAirQuality),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.sO2.toStringAsFixed(1),
                            style: kAirQualityGases(weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                          ),
                          const Text('SO₂', style: kAirQuality),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.nO2.toStringAsFixed(1),
                            style: kAirQualityGases(weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                          ),
                          const Text('NO₂', style: kAirQuality),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.o3.toStringAsFixed(1),
                            style: kAirQualityGases(weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                          ),
                          const Text('O₃', style: kAirQuality),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.cO.toStringAsFixed(1),
                            style: kAirQualityGases(weather
                                .getAirQualityDescriptionColor(widget.aqi)),
                          ),
                          const Text('CO', style: kAirQuality),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

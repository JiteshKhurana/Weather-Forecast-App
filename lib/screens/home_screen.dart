import 'package:flutter/material.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/cardReusable.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'search_screen.dart';
import 'air_quality.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class CardItem {
  late Image assetImage;
  late String time;
  late int temperature;
  late dynamic pop;
  CardItem(
      {required this.assetImage,
      required this.time,
      required this.temperature,
      required this.pop});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.locationWeather,
      required this.aQI,
      this.cityName})
      : super(key: key);
  final dynamic locationWeather;
  final dynamic aQI;
  final dynamic cityName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late Widget weatherIcon;
  late String cityName;
  late double windSpeed;
  late String description;
  late int humidity;
  late String time;
  late int feelsLike;
  late int pressure;
  late int visibility;
  late int sunriseTime;
  late String sunrise;
  late DateTime dt;
  late int sunsetTime;
  late String sunset;
  late int dewPoint;
  late int clouds;
  late String descriptionAirQuality;
  late int aqi;
  late int uV;
  late dynamic pM2_5;
  late dynamic sO2;
  late dynamic nO2;
  late dynamic o3;
  late dynamic cO;
  List<dynamic> forecastHourlyTemp = [];
  List<int> forecastHourlyTime = [];
  List<int> forecastHourlyWeatherIcon = [];
  List<dynamic> forecastHourlyPOP = [];
  List<CardItem> items = [];
  @override
  void initState() {
    updateUI(widget.locationWeather, widget.aQI, widget.cityName);
    forecastHourlyTempAdd(widget.locationWeather);
    forecastHourlyTimeAdd(widget.locationWeather);
    forecastHourlyWeatherIconAdd(widget.locationWeather);
    forecastHourlyPOPAdd(widget.locationWeather);
    cardItemAdd(0);
    super.initState();
  }

  int i = 1;
  void forecastHourlyTempAdd(dynamic weatherData) {
    if (i <= 24) {
      forecastHourlyTemp.add(weatherData['hourly'][i]['temp']);
      i++;
      forecastHourlyTempAdd(widget.locationWeather);
    }
  }

  int j = 1;
  void forecastHourlyTimeAdd(dynamic weatherData) {
    if (j <= 24) {
      forecastHourlyTime.add(weatherData['hourly'][j]['dt']);
      j++;
      forecastHourlyTimeAdd(widget.locationWeather);
    }
  }

  int k = 1;
  void forecastHourlyWeatherIconAdd(dynamic weatherData) {
    if (k <= 24) {
      forecastHourlyWeatherIcon
          .add(weatherData['hourly'][k]['weather'][0]['id']);
      k++;
      forecastHourlyWeatherIconAdd(widget.locationWeather);
    }
  }

  int l = 1;
  void forecastHourlyPOPAdd(dynamic weatherData) {
    if (l <= 24) {
      forecastHourlyPOP.add(weatherData['hourly'][l]['pop']);
      l++;
      forecastHourlyPOPAdd(widget.locationWeather);
    }
  }

  void cardItemAdd(int k) {
    if (k <= 23) {
      items.add(
        CardItem(
          assetImage: weather.getWeatherIcon(forecastHourlyWeatherIcon[k], 70),
          time: tellMeTheHourlyTime(k),
          temperature: forecastHourlyTemp[k].toInt(),
          pop: forecastHourlyPOP[k] * 100,
        ),
      );
      k++;
      cardItemAdd(k);
    }
  }

  String tellMeTheHourlyTime(int i) {
    int millis = forecastHourlyTime[i];
    DateTime dtt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
    return DateFormat('hh:mm a').format(dtt);
  }

  void updateUI(dynamic weatherData, dynamic aQI, dynamic cityNameData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          description = '';
          humidity = 0;
          windSpeed = 0;
          feelsLike = 0;
          dewPoint = 0;
          clouds = 0;
          pressure = 0;
          visibility = 0;
          aqi = 0;
          return;
        }
        double temp = weatherData['current']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['current']['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition, 200);
        cityName = cityNameData['name'];
        description = weatherData['current']['weather'][0]['description'];
        humidity = weatherData['current']['humidity'];
        windSpeed = weatherData['current']['wind_speed'];
        double feelsLikee = weatherData['current']['feels_like'];
        feelsLike = feelsLikee.toInt();
        pressure = weatherData['current']['pressure'];
        double visible = weatherData['current']['visibility'] / 1000;
        visibility = visible.toInt();
        sunriseTime = weatherData['current']['sunrise'];
        dt = DateTime.fromMillisecondsSinceEpoch(sunriseTime * 1000);
        sunrise = DateFormat('hh:mm a').format(dt);
        sunsetTime = weatherData['current']['sunset'];
        dt = DateTime.fromMillisecondsSinceEpoch(sunsetTime * 1000);
        sunset = DateFormat('hh:mm a').format(dt);
        double dewwPoint = weatherData['current']['dew_point'];
        dewPoint = dewwPoint.toInt();
        clouds = weatherData['current']['clouds'];
        dynamic uv = weatherData['current']['uvi'];
        uV = uv.toInt();
        aqi = aQI['data']['aqi'];
        descriptionAirQuality = weather.getAirQualityDescription(aqi);
        pM2_5 = aQI['data']['iaqi']['pm25']['v'];
        sO2 = aQI['data']['iaqi']['so2']['v'];
        nO2 = aQI['data']['iaqi']['no2']['v'];
        o3 = aQI['data']['iaqi']['o3']['v'];
        cO = aQI['data']['iaqi']['co']['v'];
      },
    );
  }

  Widget buildCard({required CardItem item}) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: kSecondaryColor,
        ),
        width: 185,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item.assetImage,
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kVerticalSpace(10),
                Text(item.time, style: kForecastTime),
                kVerticalSpace(10),
                Text('${item.temperature}°ᶜ', style: kValueOfTempWindHumidity),
                kVerticalSpace(10),
                Row(
                  children: [
                    Image.asset('images/icons8-umbrella-with-rain-drops-48.png',
                        height: 25),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      '${item.pop.toInt()}%',
                      style: kSmallText,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              kVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                      style: kSmallText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              kVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      color: kYellowcolor,
                      size: 25,
                    ),
                    Text(
                      cityName,
                      style: kTitle,
                    ),
                  ],
                ),
              ),
              kVerticalSpace(40),
              weatherIcon,
              kVerticalSpace(10),
              Center(
                child: GradientText(
                  description.toTitleCase(),
                  style: kDescription,
                  colors: const [
                    Colors.grey,
                    Colors.white,
                  ],
                ),
              ),
              kVerticalSpace(30),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Temp', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$temperature°ᶜ', style: kValueOfTempWindHumidity),
                      ],
                    ),
                    const VerticalDivider(
                      color: Color(0xFFbdc3c7),
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Wind', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$windSpeed m/s', style: kValueOfTempWindHumidity),
                      ],
                    ),
                    const VerticalDivider(
                      color: Color(0xFFbdc3c7),
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Humidity', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$humidity%', style: kValueOfTempWindHumidity),
                      ],
                    ),
                  ],
                ),
              ),
              kVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text('Today', style: kToday),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForecastScreen(
                              locationWeather: widget.locationWeather,
                              cityName: widget.cityName,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: const [
                          Text('Next 7 days ', style: knext7days),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              kVerticalSpace(20),
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) =>
                      buildCard(item: items[index]),
                  itemCount: 24,
                ),
              ),
              kVerticalSpace(20),
              ReusableCard(
                height: 150,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Feels like', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$feelsLike°ᶜ', style: kValueOfTempWindHumidity),
                      ],
                    ),
                    const VerticalDivider(
                      color: Color(0xFFbdc3c7),
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Pressure', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$pressure hPa', style: kValueOfTempWindHumidity),
                      ],
                    ),
                    const VerticalDivider(
                      color: Color(0xFFbdc3c7),
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Visibility', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$visibility km', style: kValueOfTempWindHumidity),
                      ],
                    ),
                  ],
                ),
              ),
              ReusableCard(
                height: 150,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text('Dew Point', style: kSmallText),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 300,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                150.0, 20.0, 150.0, 30.0),
                                            child: Container(
                                              height: 3.0,
                                              width: 60.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    // Padding
                                                    BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Dew Point',
                                            style: kValueOfTempWindHumidity,
                                          ),
                                          kVerticalSpace(20),
                                          const Text(
                                            'The dew point is the temperature to which air must be cooled to become saturated with water vapor, assuming constant air pressure and water content.\n\nWhen cooled below the dew point, moisture capacity is reduced and airborne water vapor will condense to form liquid water known as dew.\n\nWhen this occurs via contact with a colder surface, dew will form on that surface.',
                                            style: kAirQualityHelp,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.info_outline,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        kVerticalSpace(5),
                        Text('$dewPoint°ᶜ', style: kValueOfTempWindHumidity),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Cloud Cover', style: kSmallText),
                        kVerticalSpace(5),
                        Text('$clouds%', style: kValueOfTempWindHumidity),
                      ],
                    ),
                  ],
                ),
              ),
              ReusableCard(
                height: 150,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sunrise', style: kSmallText),
                        kVerticalSpace(5),
                        Text(sunrise, style: kValueOfTempWindHumidity),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sunset', style: kSmallText),
                        kVerticalSpace(5),
                        Text(sunset, style: kValueOfTempWindHumidity),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AirQuality(
                        aqi: aqi,
                        pM2_5: pM2_5,
                        sO2: sO2,
                        nO2: nO2,
                        o3: o3,
                        cO: cO,
                        cityName: cityName);
                  }));
                },
                child: ReusableCard(
                  height: 150,
                  cardChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Air Quality Index',
                              style: kSmallText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      kVerticalSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.air_sharp,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '$aqi',
                                style: kValueOfTempWindHumidity,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              descriptionAirQuality,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: weather
                                      .getAirQualityDescriptionColor(aqi),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
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
                        heightFactor: 0.75,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    150.0, 20.0, 150.0, 30.0),
                                child: Container(
                                  height: 3.0,
                                  width: 60.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        // Padding
                                        BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                'UV Index',
                                style: kValueOfTempWindHumidity,
                              ),
                              kVerticalSpace(20),
                              const Text(
                                'Low (2 or less)',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                              kVerticalSpace(10),
                              const Text(
                                'No need for special precautions when exposed to sunlight. People with sensitive skin should apply sunscreen.',
                                style: kAirQualityHelp,
                              ),
                              kVerticalSpace(20),
                              const Text(
                                'Moderate (3 to 5)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                              kVerticalSpace(10),
                              const Text(
                                'Sunburn is possible with 2-3 hours of exposure to sunlight. Wear a hat and sunglasses and apply sunscreen.',
                                style: kAirQualityHelp,
                              ),
                              kVerticalSpace(20),
                              const Text(
                                'High (6 to 7)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                              ),
                              kVerticalSpace(10),
                              const Text(
                                'Sunburn is possible with 1-2 hours of exposure to sunlight. Stay in the shade during the day and wear a long-sleeved shirt,hat and sunglasses if you go out. Be sure to apply sunscreen.',
                                style: kAirQualityHelp,
                              ),
                              kVerticalSpace(20),
                              const Text(
                                'Very High (8 to 10)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              kVerticalSpace(10),
                              const Text(
                                'Avoid going out between 10AM and 3PM. And stay indoors or in the shade. Wear a long-sleeved shirt,hat and sunglasses. Periodically reapply sunscreen.',
                                style: kAirQualityHelp,
                              ),
                              kVerticalSpace(20),
                              const Text(
                                'Extreme (11 or Higher)',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red),
                              ),
                              kVerticalSpace(10),
                              const Text(
                                'Sunburn is possible with less than an hour of exposure to sunlight. Stay indoors if possible and wear a long-sleeved shirt,hat and sunglasses if you go out. Periodically reapply sunscreen.',
                                style: kAirQualityHelp,
                              ),
                              kVerticalSpace(20),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ReusableCard(
                  height: 150,
                  cardChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'UV Index',
                              style: kSmallText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      kVerticalSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(
                                  weather.getUVIndexIcon(uV),
                                  color: weather.getUVIndexIconColor(uV),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '$uV',
                                style: kValueOfTempWindHumidity,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              weather.getUVIndexDescription(uV),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: weather.getUVIndexIconColor(uV),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

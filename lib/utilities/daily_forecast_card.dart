import 'package:flutter/material.dart';
import 'constants.dart';

class DailyForecastCard extends StatelessWidget {
  const DailyForecastCard(
      {Key? key, required this.icon, required this.text, required this.value})
      : super(key: key);

  final IconData icon;
  final String text;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        Text(
          text,
          style: kForecastAirQuality,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            '$value',
            style: kForecastAirQuality,
          ),
        )
      ],
    );
  }
}

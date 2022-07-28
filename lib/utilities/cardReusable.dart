import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({Key? key, required this.cardChild, required this.height})
      : super(key: key);

  final Widget cardChild;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
      height: height.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kSecondaryColor,
      ),
      child: cardChild,
    );
  }
}

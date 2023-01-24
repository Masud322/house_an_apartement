import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class HouseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
              MenuInfo(
                  imageUrl: 'assets/images/bedroom.png',
                  content: '5 Bedroom\n3 Master Bedroom'),
              MenuInfo(
                  imageUrl: 'assets/images/bath.png',
                  content: '5 Bathroom\n3 Toilet'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              MenuInfo(
                  imageUrl: 'assets/images/kitchen.png',
                  content: '2 Kitchen\n120 sqft'),
              MenuInfo(
                  imageUrl: 'assets/images/parking.png',
                  content: '2 Parking\n120 sqft'),
            ],
          )
        ],
      ),
    );
  }
}

class MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;
  const MenuInfo({Key? key, required this.imageUrl, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            Image.asset(imageUrl),
            const SizedBox(width: 20),
            Text(
              content,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
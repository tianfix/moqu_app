import 'package:flutter/material.dart';
import 'package:moqu_app/theme.dart';

class SliderPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;

  SliderPage({this.imageUrl, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 78, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: 278,
            height: 194,
          ),
          SizedBox(height: 44),
          Text(
            title,
            style: titleOnboarding,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            subTitle,
            style: bodyText.copyWith(color: greyColor),
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}

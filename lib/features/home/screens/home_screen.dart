import 'package:flutter/material.dart';
import 'package:news_app/utils/app_color.dart';
import 'package:news_app/utils/dimensions.dart';
import 'package:news_app/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () {},
          child: const Icon(Icons.menu, size: 20, color: AppColors.whiteColor),
        ),
        title: Text(
          'News App',
          style: robotoMedium.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

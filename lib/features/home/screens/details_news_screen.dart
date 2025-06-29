import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_image.dart';
import 'package:news_app/utils/app_color.dart';
import 'package:news_app/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/headline_model.dart';
import '../model/news_model.dart';

class DetailsNewsScreen extends StatelessWidget {
  const DetailsNewsScreen({super.key, required this.fullNews,});

  final NewsModel fullNews;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Card(
            child: CustomNetworkImage(
              image: "${fullNews.urlToImage}",
              width: double.infinity,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${fullNews.author}",
                    style: robotoBold.copyWith(color: Colors.purpleAccent),
                  ),
                ),

                Text(
                  "${fullNews.title}",
                  style: robotoBold.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  "${fullNews.content}",
                  style: robotoBold.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Description',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),

                InkWell(
                  onTap: () {},
                  child: Text(
                    "${fullNews.description}",
                    style: robotoBold.copyWith(color: AppColors.black),
                  ),
                ),
                const SizedBox(height: 5),

                InkWell(
                  onTap: () {},
                  child: Text(
                    "${fullNews.url}",
                    style: robotoBold.copyWith(color: AppColors.appBarColor),
                  ),
                ),

                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${fullNews.publishedAt}",
                    style: robotoBold.copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}

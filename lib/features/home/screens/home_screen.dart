import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_drop_down_button.dart';
import 'package:news_app/common/widgets/custom_image.dart';
import 'package:news_app/common/widgets/custom_text_field.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:news_app/features/home/screens/details_news_screen.dart';
import 'package:news_app/utils/app_color.dart';
import 'package:news_app/utils/dimensions.dart';
import 'package:news_app/utils/styles.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Get.find<HomeController>();
    // for pageNation
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.find<HomeController>().incrementNewsData();
        Get.find<HomeController>().getAllNewsData();
      }
    });
    super.initState();
  }

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
        actions: [
          GetBuilder<HomeController>(
            builder: (homeController) {
              return InkWell(
                onTap: () {
                  homeController.activeSearchButton();
                },
                child: const Icon(
                  Icons.search,
                  size: 22,
                  color: AppColors.whiteColor,
                ),
              );
            },
          ),
          const SizedBox(width: 13),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 2, bottom: 2),
        child: GetBuilder<HomeController>(
          builder: (homeController) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header:const WaterDropHeader(),
              controller: homeController.refreshController,
              onRefresh: homeController.onRefresh,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      homeController.isSearch
                          ? Column(
                            children: [
                              CustomTextField(
                                controller: homeController.searchController,
                                hintText: 'Search here',
                                prefixIcon: Icons.search,
                                onComplete: () {
                                  homeController.allNews.clear();
                                  homeController.getAllNewsData();
                                },
                              ),
                              const SizedBox(height: 5),
                              CustomDropdownButton(
                                items: const [
                                  'relevancy',
                                  'popularity',
                                  'publishedAt',
                                ],
                                hintText: 'Select',
                                onChanged: (value) {
                                  homeController.selectedFilterValue =
                                      value.toString();
                                  homeController.getFilterData();
                                },
                              ),
                            ],
                          )
                          : const SizedBox(),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child:
                            homeController.allHeadline.isEmpty
                                ? const SizedBox.shrink()
                                : CarouselSlider.builder(
                                  itemCount: homeController.allHeadline.length,
                                  itemBuilder: (context, index, realIdx) {
                                    var dataHead =
                                        homeController.allHeadline[index];
                                    return Column(
                                      children: [
                                        CustomNetworkImage(
                                          image: "${dataHead.urlToImage}",
                                          height: 180,
                                          width: double.infinity,
                                        ),
                                        const SizedBox(height: 2),
                                      ],
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 220,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.85,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration: const Duration(
                                      milliseconds: 800,
                                    ),
                                    enableInfiniteScroll: true,
                                  ),
                                ),
                      ),
                      ListView.builder(
                        itemCount: homeController.allNews.length,
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var value = homeController.allNews[index];
                          return InkWell(
                            onTap: () {
                              Get.to(
                                DetailsNewsScreen(
                                  fullNews: homeController.allNews[index],
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              color: AppColors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      image: "${value.urlToImage}",
                                      height: 100,
                                      width: 100,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${value.title}",
                                            style: robotoMedium.copyWith(
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            "${value.content}",
                                            style: robotoMedium.copyWith(
                                              color: AppColors.black.withAlpha(
                                                150,
                                              ),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              timeago.format(
                                                DateTime.parse(
                                                  value.publishedAt!,
                                                ),
                                              ),
                                              style: robotoMedium.copyWith(
                                                color: AppColors.green,
                                              ),
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
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_image.dart';
import 'package:news_app/common/widgets/custom_text_field.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:news_app/utils/app_color.dart';
import 'package:news_app/utils/dimensions.dart';
import 'package:news_app/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    Get.find<HomeController>();
    // for pageNation
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
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
              return InkWell(onTap: (){
                homeController.activeSearchButton();
              },
              child: const Icon(Icons.search,size: 22,color: AppColors.whiteColor,),);
            }
          ),
          const SizedBox(width: 13,),
        ],

      ),
      body: Container(
        width: double.infinity,
       padding: EdgeInsets.only(left: 2,bottom: 2),
        child: GetBuilder<HomeController>(
          builder: (homeController) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                homeController.isSearch?  CustomTextField(
                  controller: homeController.searchController,
                  hintText: 'Search here',
                  prefixIcon: Icons.search,
                  onComplete: (){
                    homeController.allNews.clear();
                    homeController.getAllNewsData();
                  },
                ) : const SizedBox(),
                  const SizedBox(height: 18,),
                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child:
                        homeController.allHeadline.isEmpty
                            ? const SizedBox.shrink()
                            : CarouselSlider.builder(
                              itemCount: homeController.allHeadline.length,
                              itemBuilder: (context, index, realIdx) {
                                var dataHead = homeController.allHeadline[index];
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: homeController.allNews.length,
                      itemBuilder: (context, index) {
                        var data = homeController.allNews[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  image: "${data.urlToImage}",
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${data.title}", style: robotoMedium),
                                      Text(
                                        "${data.content}",
                                        style: robotoMedium,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

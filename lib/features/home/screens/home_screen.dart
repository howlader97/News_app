import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_image.dart';
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

  @override
  void initState() {
    Get.find<HomeController>();
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
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: GetBuilder<HomeController>(
            builder: (homeController) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics() ,
                      itemCount: homeController.allNews.length,
                      itemBuilder: (context,index){
                        var data= homeController.allNews[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CustomNetworkImage(image: "${data.urlToImage}",height: 100,width: 100,),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text("${data.title}",style: robotoMedium,),
                                    Text("${data.content}",style: robotoMedium,maxLines: 2,),

                                  ],),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

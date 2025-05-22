import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_snackbar.dart';
import 'package:news_app/features/home/model/news_model.dart';

import 'package:news_app/features/home/repository/home_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    show RefreshController;

class HomeController extends GetxController implements GetxService {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

   List<NewsModel> _allNews = [];

  List<NewsModel> get allNews=> _allNews;

  //listType all api like getData create same function
  getAllNewsData() async {
    _isLoading = true;
    update();
    Response response = await homeRepository.getAllNewsData();
    if (response.statusCode == 200) {
      //first data in map and data set in list
      _allNews.addAll(
        response.body["articles"]
            .map<NewsModel>((data) => NewsModel.fromJson(data))
            .toList(),
      );

      /* //data set in loop structure
         for(var data in response.body["articles"]){
           _allNews.add(NewsModel.fromJson(data));
         }*/
    } else{
      showCustomSnackBar("Something is Wring, pls Try again");
    }
    _isLoading=false;
    update();

  }


  @override
  void onInit() {
    getAllNewsData();
    super.onInit();

  }
}

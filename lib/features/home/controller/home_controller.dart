import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_app/common/widgets/custom_snackbar.dart';
import 'package:news_app/features/home/model/headline_model.dart';
import 'package:news_app/features/home/model/news_model.dart';

import 'package:news_app/features/home/repository/home_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    show RefreshController;

class HomeController extends GetxController implements GetxService {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});


TextEditingController _searchController=TextEditingController();
TextEditingController get searchController => _searchController;


  //listType all api like getData create same function
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  activeSearchButton(){
    _isSearch =! _isSearch;
    update();
  }

  List<NewsModel> _allNews = [];
  List<NewsModel> get allNews=>_allNews;

  List <HeadlineModel> _allHeadline =[];
  List<HeadlineModel> get allHeadline => _allHeadline;

  int _page =1;
  int _pageSize =10;


  getAllNewsData()async{
    _isLoading =true;
    update();
    Response response =await homeRepository.getAllNewsData(
      page: _page,
      pageSize: _pageSize,
      search: _searchController.text.isEmpty? "sports": _searchController.text.toString(),
      sortBy: selectedFilterValue,
    );
    if(response.statusCode == 200){
      _allNews.addAll(
          response.body["articles"]
              .map<NewsModel>((data) => NewsModel.fromJson(data))
              .toList());
      /* //data set in loop structure
         for(var data in response.body["articles"]){
           _allNews.add(NewsModel.fromJson(data));
         }*/

    }else{
      showCustomSnackBar("Something is wrong! please try again");
    }
    _isLoading=false;
    update();
  }

  getTopHeadlines()async{
    _isLoading=true;
    update();
    Response response=await homeRepository.getTopHeadlines();
    if(response.statusCode ==200){
      _allHeadline.addAll(
        response.body["articles"].map<HeadlineModel>((data) => HeadlineModel.fromJson(data)).toList()
      );
    }else{
      showCustomSnackBar("Something is wrong! please try again");
    }
    _isLoading=false;
    update();
  }
  incrementNewsData() {
    _page++;
    update();
  }

  String selectedFilterValue = "publishedAt";

  getFilterData(){
    _page=1;
    _allNews=[];
    getAllNewsData();
  }



  @override
  void onInit() {
    getAllNewsData();
    getTopHeadlines();
    super.onInit();
  }


}

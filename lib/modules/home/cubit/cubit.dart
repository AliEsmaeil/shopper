import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/models/category_model.dart';
import 'package:page_view/models/home_data.dart';
import 'package:page_view/modules/home/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  int currentIndex = 0;
  HomeDataModel? homeModel;
  CategoryModel? categoryModel;
  Map<int, bool> localFavorites = {};

  HomePageCubit() : super(HomePageInitialState()) {
    getHomeData();
    getCategories();
  }

  static HomePageCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);

  void changeNavigationDestination(int index) {
    currentIndex = index;
    emit(HomePageNavBarChangedState());
  }

  void getHomeData() async {
    emit(HomePageLoadingState());

    await DioHelper.getData(endPointPath: ServerEndPoints.HOME).then((value) {
      homeModel = HomeDataModel.fromJson(value);
      homeModel?.data.products.forEach((element) {
        localFavorites[element.id] = element.inFavorites;
      });

      emit(HomePageGotDataState());
    }).catchError((error) {
      emit(HomePageErrorState());
      throw error;
    });
  }

  void getCategories() async {
    await DioHelper.getData(endPointPath: ServerEndPoints.GATEGORIES)
        .then((value) {
      categoryModel = CategoryModel.fromJson(value);
      emit(HomePageGotCategoriesState());
    }).catchError((error) {
      debugPrint('error getting categories in home page : $error');
      emit(HomePageCategoriesErrorState());
      throw error;
    });
  }

  void changeFavoriteProduct(int productId) {
    // change it locally

    localFavorites[productId] = !localFavorites[productId]!;
    emit(HomePageChangeLocalFavoriteState());

    // change it remotely

    DioHelper.postData(
        endPointPath: ServerEndPoints.FAVORITES,
        data: {'product_id': productId}).then((value) {
      emit(HomePageSuccessRemoteFavoriteState());
    }).catchError((error) {
      emit(HomePageErrorRemoteFavoriteState());
      debugPrint('error updating favorites remotely');
    });
  }

/*  void getUserFavorites(){

    emit(HomePageLoadingState());

    DioHelper.getData(endPointPath: ServerEndPoints.FAVORITES,).then((value) {

      favoritesModel = FavoritesModel.fromJson(value);
      print('ali: fav model is successfully initialized');

      emit(HomePageSuccessRemoteFavoriteState());

    }).catchError((error){
      debugPrint('error getting remote favorites $error');
      emit(HomePageErrorRemoteFavoriteState());
    });



  }*/
}

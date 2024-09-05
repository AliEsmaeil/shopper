import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/models/search_model.dart';
import 'package:page_view/modules/search/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchData? searchData;
  String lastSearchWord = '';

  SearchCubit() : super(InitialSearchState());

  static SearchCubit getCubit(BuildContext context) => BlocProvider.of(context);

  void search(String word) {
    emit(LoadingSearchState());
    lastSearchWord = word;

    DioHelper.postData(
        endPointPath: ServerEndPoints.SEARCH_PRODUCTS,
        data: {'text': word}).then((value) {
      if (lastSearchWord.length == (value.requestOptions.data['text'].length)) {
        searchData = SearchData.fromJson(value.data['data']);
        emit(SuccessSearchState());
      }
    }).catchError((error) {
      emit(ErrorSearchState());
    });
  }
}

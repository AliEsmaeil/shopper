import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/models/faq_model.dart';
import 'package:page_view/modules/faqs/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

final class FaqsScreenCubit extends Cubit<FaqsScreenStates> {
  List<Faq> faqs = [];

  FaqsScreenCubit() : super(FaqsScreenLoadingState()) {
    getFaqsData();
  }

  static FaqsScreenCubit getCubit(context) => BlocProvider.of(context);

  void getFaqsData() {
    emit(FaqsScreenLoadingState());

    DioHelper.getData(endPointPath: ServerEndPoints.FAQS).then((value) {
      value['data']['data'].forEach((e) {
        faqs.add(Faq.fromJson(e));
      });

      emit(FaqsScreenGotDataState());
    }).catchError((error) {});
  }
}

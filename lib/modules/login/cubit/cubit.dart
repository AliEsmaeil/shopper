import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/models/login_model.dart';
import 'package:page_view/modules/login/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  bool isVisible = false;

  LoginCubit() : super(InitialLoginState());

  static LoginCubit getCubit(BuildContext context) => BlocProvider.of(context);

  void changeVisibility() {
    isVisible = !isVisible;
    emit(PasswordVisibilityState());
  }

  void login({required String email, required String password}) async {
    emit(LoadingLoginState());
    print('executing login now !!');
    await DioHelper.postData(
      endPointPath: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      emit(SuccessLoginState(
          response: LoginResponse.fromJson(response: value.data)));
    }).catchError((error) {
      emit(ErrorLoginState());
    });
  }
}

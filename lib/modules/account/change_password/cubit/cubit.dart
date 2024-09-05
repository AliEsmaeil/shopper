import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/modules/account/change_password/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  bool oldPasswordVisibility = false;
  bool newPasswordVisibility = false;

  void changeOldPasswordVisibility() {
    oldPasswordVisibility = !oldPasswordVisibility;
    emit(ChangePasswordVisibilityState());
  }

  void changeNewPasswordVisibility() {
    newPasswordVisibility = !newPasswordVisibility;
    emit(ChangePasswordVisibilityState());
  }

  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit getCubit(context) => BlocProvider.of(context);

  void changePassword({required oldPassword, required newPassword}) {
    emit(ChangePasswordLoadingState());

    DioHelper.postData(endPointPath: ServerEndPoints.CHANGE_PASSWORD, data: {
      'current_password': oldPassword,
      'new_password': newPassword,
    }).then((value) {
      if (value.data['status']) {
        emit(ChangePasswordSuccessState(value.data['message']));
      } else {
        emit(ChangePasswordErrorState(value.data['message']));
      }
      return value;
    }).catchError((error) {
      emit(ChangePasswordErrorState(error.toString()));
      return error;
    });
  }
}

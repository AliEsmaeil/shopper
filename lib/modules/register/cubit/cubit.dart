import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/models/register_user.dart';
import 'package:page_view/utils/image_getter.dart';
import 'package:page_view/utils/image_src.dart';
import 'package:page_view/modules/register/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenStates> {
  File? image;
  ImagePicker picker = ImagePicker();
  bool isVisible = false;

  RegisterScreenCubit() : super(RegisterScreenInitialState());

  static RegisterScreenCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);

  void changePasswordVisibility() {
    isVisible = !isVisible;
    emit(RegisterScreenChangeVisibilityState());
  }

  void getImage(MyImageSource source) async {
    image = await getImageFromGalleryOrCamera(imageSource: source);
    emit(RegisterScreenGotImageState());
  }

  Future<void> registerUser(RegisterUser userData) async {
    DioHelper.postData(
            endPointPath: ServerEndPoints.REGISTER, data: userData.toJson())
        .then((value) {
      if (image?.path != null) {
        SharedPrefHelper.writeData(
            key: SharedPreferenceConstants.userImage, value: image!.path);
      }
      emit(RegisterScreenSuccessRegisterState());
    }).catchError((error) {
      emit(RegisterScreenErrorRegisterState(error.toString()));

      print('error while uploading registered user data');
    });
  }
}

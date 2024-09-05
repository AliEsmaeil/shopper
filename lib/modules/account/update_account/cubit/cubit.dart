import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/account/update_account/cubit/states.dart';
import 'package:page_view/network/remote/dio_helper.dart';
import 'package:page_view/utils/image_getter.dart';
import 'package:page_view/utils/image_src.dart';

class UpdateAccountCubit extends Cubit<UpdateAccountScreenStates> {
  File? image;
  bool passwordVisibility = false;

  UpdateAccountCubit() : super(UpdateAccountInitialState()) {
    initiateImage();
  }

  static UpdateAccountCubit getCubit(context) => BlocProvider.of(context);

  void initiateImage() {
    var path =
        SharedPrefHelper.readData(key: SharedPreferenceConstants.userImage);
    if (path != null) {
      image = File(path);
    }
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    emit(UpdateAccountPasswordVisibilityState());
  }

  void pickImage(MyImageSource source) async {
    await getImageFromGalleryOrCamera(imageSource: source).then((value) {
      if (value != null) {
        image = value;
        emit(UpdateAccountPickedImageState());
      }
    }).catchError((error) {});
  }

  void updateAccount({
    required String name,
    required String phone,
    required String email,
    required String password,
    // api doesn't support image uploading or downloading, it's a mock image that's displayed on the server
    //because of that reason, we save the image locally(it's dangerous and bad practice to do but it's for learning)
  }) {
    emit(UpdateAccountLoadingState());

    DioHelper.putData(endPointPath: ServerEndPoints.UPDATE_PROFILE, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      if (value['status']) {
        if (image != null) {
          SharedPrefHelper.writeData(
              key: SharedPreferenceConstants.userImage, value: image!.path);
          SharedPrefHelper.writeData(
              key: SharedPreferenceConstants.userData, value: [name, email]);
        }
        emit(UpdateAccountSuccessState(value['message']));
      } else {
        emit(UpdateAccountErrorState(value['message']));
      }
    }).catchError((error) {
      emit(UpdateAccountErrorState('error in update your data $error'));
    });
  }
}

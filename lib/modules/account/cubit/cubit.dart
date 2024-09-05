import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/models/login_model.dart';
import 'package:page_view/network/remote/dio_helper.dart';

final class AccountScreenFuture {
  UserData? userData;

  Future<UserData> getUserData() {
    return DioHelper.getData(endPointPath: ServerEndPoints.PROFILE)
        .then((value) {
      return userData = UserData.fromJson(json: value['data']);
    }).catchError((error)=>error);
  }
}

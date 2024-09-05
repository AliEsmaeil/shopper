import 'package:page_view/models/login_model.dart';

interface class LoginStates{}

class InitialLoginState extends LoginStates{}


class LoadingLoginState extends LoginStates{}

class SuccessLoginState extends LoginStates{

  LoginResponse response;
  SuccessLoginState({required this.response});

}

class ErrorLoginState extends LoginStates{}

class PasswordVisibilityState extends LoginStates{}

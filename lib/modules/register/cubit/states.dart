abstract base class RegisterScreenStates{}

final class RegisterScreenInitialState extends RegisterScreenStates{}

final class RegisterScreenGotImageState extends RegisterScreenStates{}


final class RegisterScreenSuccessRegisterState extends RegisterScreenStates{}

final class RegisterScreenErrorRegisterState extends RegisterScreenStates{

  String error;
  RegisterScreenErrorRegisterState(this.error);

}

final class RegisterScreenChangeVisibilityState extends RegisterScreenStates{}
abstract base class ChangePasswordStates{}

final class ChangePasswordInitialState extends ChangePasswordStates{}

final class ChangePasswordLoadingState extends ChangePasswordStates{}

final class ChangePasswordSuccessState extends ChangePasswordStates{
  String message;
  ChangePasswordSuccessState(this.message);
}

final class ChangePasswordErrorState extends ChangePasswordStates{
  String message;
  ChangePasswordErrorState(this.message);
}

final class ChangePasswordVisibilityState extends ChangePasswordStates{}
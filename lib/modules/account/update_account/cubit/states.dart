abstract base class UpdateAccountScreenStates{}

final class UpdateAccountInitialState extends UpdateAccountScreenStates{}

final class UpdateAccountLoadingState extends UpdateAccountScreenStates{}

final class UpdateAccountPickedImageState extends UpdateAccountScreenStates{}

final class UpdateAccountPasswordVisibilityState extends UpdateAccountScreenStates{}

final class UpdateAccountSuccessState extends UpdateAccountScreenStates{
  String message;

  UpdateAccountSuccessState(this.message);
}

final class UpdateAccountErrorState extends UpdateAccountScreenStates{

  String message;

  UpdateAccountErrorState(this.message);
}

abstract class LoginStates {}

class LoginInitState extends LoginStates{}

class ChangeVisibilityPasswordState extends LoginStates{}

class UserLoginLoadingState extends LoginStates{}

class UserLoginSuccessState extends LoginStates{
  final String uId;

  UserLoginSuccessState(this.uId);
}

class UserLoginErrorState extends LoginStates{
  final String error;
  UserLoginErrorState(this.error);
}

class RigesterDataLoadingState extends LoginStates{}

class RigesterDataSuccessState extends LoginStates{}

class RigesterDataErrorState extends LoginStates{
  final String error;

  RigesterDataErrorState(this.error);
}

class CreateUserDataSuccessState extends LoginStates{
    final String uId;

  CreateUserDataSuccessState(this.uId);

}

class CreateUserDataErrorState extends LoginStates{
  final String error;

  CreateUserDataErrorState(this.error);
}
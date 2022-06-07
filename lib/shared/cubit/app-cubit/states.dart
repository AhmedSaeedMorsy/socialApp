abstract class AppStates {}

class AppInitState extends AppStates {}

class UserInfoLoadingState extends AppStates {}

class UserInfoSuccessState extends AppStates {}

class UserInfoErrorState extends AppStates {
  final String error;
  UserInfoErrorState(this.error);
}

class ProfileImagePickedSuccessState extends AppStates{}

class ProfileImagePickedErrorState extends AppStates{}

class CoverImagePickedSuccessState extends AppStates{}

class CoverImagePickedErrorState extends AppStates{}

class UploadProfileImageLoadingState extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadProfileImageErrorState extends AppStates{}

class UploadCoverImageLoadingState extends AppStates{}

class UploadCoverImageSuccessState extends AppStates{}

class UploadCoverImageErrorState extends AppStates{}

class UpdateProfileInfoLoadingState extends AppStates{}

class UpdateProfileInfoSuccessState extends AppStates{}

class UpdateProfileInfoErrorState extends AppStates{}
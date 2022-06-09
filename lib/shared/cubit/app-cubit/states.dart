import 'package:social_app/shared/cubit/app-cubit/cubit.dart';

abstract class AppStates {}

class AppInitState extends AppStates {}

class UserInfoLoadingState extends AppStates {}

class UserInfoSuccessState extends AppStates {}

class UserInfoErrorState extends AppStates {
  final String error;
  UserInfoErrorState(this.error);
}

class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class CoverImagePickedSuccessState extends AppStates {}

class CoverImagePickedErrorState extends AppStates {}

class UploadProfileImageLoadingState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UploadCoverImageLoadingState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

class UpdateProfileInfoLoadingState extends AppStates {}

class UpdateProfileInfoSuccessState extends AppStates {}

class UpdateProfileInfoErrorState extends AppStates {}

class PostImagePickedSuccessState extends AppStates {}

class PostImagePickedErrorState extends AppStates {}

class UploadPostImageLoadingState extends AppStates{}

class UploadPostImageSuccessState extends AppStates{}

class UploadPostImageErrorState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class RemovePostImageState extends AppStates{}

class GetPostLoadingState extends AppStates {}

class GetPostSuccessState extends AppStates {}

class GetPostErrorState extends AppStates {
  final String error;
  GetPostErrorState(this.error);
}
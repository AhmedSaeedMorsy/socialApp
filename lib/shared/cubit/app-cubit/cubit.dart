// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modules/chat/chat.dart';
import 'package:social_app/modules/home/home.dart';
import 'package:social_app/modules/profile/profile.dart';
import 'package:social_app/modules/user/user.dart';
import 'package:social_app/shared/constant.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserInfo() {
    emit(UserInfoLoadingState());
    FirebaseFirestore.instance.collection("user").doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(UserInfoSuccessState());
    }).catchError((error) {
      emit(UserInfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<Widget> screen = const [
    HomeScreen(),
    UserScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print("Not found profile image ");
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      
      print(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("Not found cover image ");
      emit(CoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';
  void uploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  String coverImageUrl = "";
  void uploadCoverImage() {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadCoverImageErrorState());
    });
  }

  void updateprofileInfo({
    required String name,
    required String email,
    required String phone,
    required String bio,
    required String uId,
    required String image,
    required String cover,
  }) {
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (profileImage != null && coverImage != null) {
      uploadProfileImage();
      uploadCoverImage();
    } else {
      UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        bio: bio, cover: cover, image:image, uId: uId,
      
      );
      FirebaseFirestore.instance
          .collection("user")
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserInfo();
      }).catchError((error) {
        print(error.toString());
        emit(UpdateProfileInfoErrorState());
      });
    }
  }

  backgroundProfileImage() {
    if (profileImage == null) {
      return NetworkImage(
        model!.image,
      );
    } else {
      FileImage(profileImage!);
    }
  }

  backgroundCoverImage() {
    if (coverImage == null) {
      return NetworkImage(
        model!.cover,
      );
    } else {
      FileImage(coverImage!);
    }
  }
}

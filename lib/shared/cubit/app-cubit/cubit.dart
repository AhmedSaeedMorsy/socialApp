import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/post_model.dart';
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
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
    required String uId,
    required String cover,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateprofileInfo(
          bio: bio,
          cover: cover,
          email: email,
          image: value,
          name: name,
          phone: phone,
          uId: uId,
        );
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

  void uploadCoverImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
    required String uId,
    required String image,
  }) {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateprofileInfo(
          bio: bio,
          cover: value,
          email: email,
          image: image,
          name: name,
          phone: phone,
          uId: uId,
        );
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
    emit(UpdateProfileInfoLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      cover: cover,
      image: image,
      uId: uId,
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

  backgroundProfileImage() {
    if (profileImage == null) {
      return NetworkImage(
        model!.image,
      );
    } else {
      return FileImage(profileImage!);
    }
  }

  backgroundCoverImage() {
    if (coverImage == null) {
      return NetworkImage(
        model!.cover,
      );
    } else {
      return FileImage(coverImage!);
    }
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String name,
    required String dateTime,
    required String text,
    required String image,
    required String uId,
  }) {
    emit(UploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          image: image,
          name: name,
          text: text,
          uId: uId,
          postImage: value,
        );
        emit(UploadPostImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({
    required String name,
    required String dateTime,
    required String text,
    required String image,
    required String uId,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: name,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
      image: image,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection("post")
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<int> likes = [];
  List<String> postsId = [];
  void getPost() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection("post").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          posts.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
          likes.add(value.docs.length);
          emit(GetPostSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(GetPostErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetPostErrorState(error.toString()));
    });
  }

  void likesPost(String postId) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("likes")
        .doc(uId)
        .set(
      {
        "like": true,
      },
    ).then((value) {
      emit(LikesPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikesPostErrorState(error.toString()));
    });
  }

  List<UserModel> allUsers = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection("user").get().then((value) {
      value.docs.forEach((element) {
        if (element.id != uId) {
          allUsers.add(UserModel.fromJson(element.data()));
        }
        emit(GetAllUsersSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState());
    });
  }

  void sendMessage({
    required String dateTime,
    required String message,
    required String senderId,
    required String recieverId,
  }) {
    ChatModel model = ChatModel(
        message: message,
        senderId: senderId,
        dateTime: dateTime,
        recieverId: recieverId);
    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("message")
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection("user")
        .doc(recieverId)
        .collection("chats")
        .doc(uId)
        .collection("message")
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
  }

  List<ChatModel> chat = [];

  void getMessage({required String recieverId}) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("message")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      chat = [];
      event.docs.forEach((element) {
        chat.add(ChatModel.fromJson(element.data()));
        emit(GetMessageSuccessState());
      });
    });
  }
}

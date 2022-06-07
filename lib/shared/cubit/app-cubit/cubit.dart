import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}

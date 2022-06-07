// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/shared/cubit/login_cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isShown = true;
  Icon suffix = const Icon(Icons.visibility_off_outlined);
  void changeVisibilityPassword() {
    isShown = !isShown;
    suffix = isShown
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(ChangeVisibilityPasswordState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          print(value.user!.email);

          print(value.user!.uid);

          emit(UserLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(UserLoginErrorState(error.toString()));
    });
  }

  void userRigester({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RigesterDataLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email);
      createUser(name: name, phone: phone, email: email, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString);
      emit(RigesterDataErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String email,
    required String uId,
    String image =
        "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1654375165~exp=1654375765~hmac=a1e952e21a194faf086fa93238f5e8617442bce818c1c2b3396ce2e8587e4714&w=1060",
    String cover =
        "https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1380&t=st=1654375235~exp=1654375835~hmac=b3a1795eef95b9f34366328cedb0ceea3178d0dd339cbe807a560046dd08fbac",
    String bio = "Write Your Bio",
  }) {
    UserModel model= UserModel(name:name, bio: bio, cover: cover, email: email, image: image, phone: phone, uId: uId,);

    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(model.toMap())
        .then((value) {

      emit(CreateUserDataSuccessState(uId));
    }).catchError((error) {

      print(error.toString());
      emit(CreateUserDataErrorState(error.toString()));
    });
  }
}

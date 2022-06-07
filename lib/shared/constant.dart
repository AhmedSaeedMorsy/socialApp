import 'package:flutter/material.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/local/cache_helper.dart';

String? uId  ;

Widget nextScreen() {
  late Widget widget;
  uId = CacheHelper.getData(key: "uId");
  if (uId != null) {
    widget = HomeLayOut();
  } else {
    widget = LoginScreen();
  }
  return widget;
}

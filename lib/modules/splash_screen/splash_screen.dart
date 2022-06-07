// ignore_for_file: file_names


import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_app/shared/constant.dart';

import 'package:social_app/shared/local/cache_helper.dart';

import '../../layout/home_layout.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Icons.chat,
        splashIconSize: 200.0,
        
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        nextScreen:nextScreen (),
      
      ),
    );
  }
  
}

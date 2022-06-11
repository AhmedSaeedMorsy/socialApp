import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/splash_screen/splash_screen.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/login_cubit/cubit.dart';
import 'package:social_app/shared/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..getUserInfo()
            ..getPost()
            ..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: them,
        home: SplashScreen(),
      ),
    );
  }
}

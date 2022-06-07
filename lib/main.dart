import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/splash_screen/splash_screen.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/login_cubit/cubit.dart';
import 'package:social_app/shared/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          create: (context) => AppCubit()..getUserInfo(),
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

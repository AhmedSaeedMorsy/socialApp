// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/constant.dart';
import 'package:social_app/shared/cubit/login_cubit/cubit.dart';
import 'package:social_app/shared/cubit/login_cubit/states.dart';
import 'package:social_app/shared/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is UserLoginErrorState) {
          showToast(
              message: state.error,
              state: toast.error,
              context: context,
              title: 'Oops');
        } else if (state is UserLoginSuccessState) {
          CacheHelper.setData(key: "uId", value: state.uId).then((value) {
            navigatorPushAndReblace(context, const HomeLayOut());
            uId = state.uId;
          }).catchError((error) {
          });
        }
        uId = CacheHelper.getData(key: "uId");
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email Adress";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: "Password",
                          obscure: LoginCubit.get(context).isShown,
                          prefixIcon: const Icon(Icons.lock_outlined),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                          onFieldSubmeitted: (String value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changeVisibilityPassword();
                            },
                            icon: LoginCubit.get(context).suffix,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilderRec(
                          condition: state is! UserLoginLoadingState,
                          builder: (context) => defaultButton(
                              text: "Login",
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an Account ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                              onPressed: () {
                                navigatTo(context, RegisterScreen());
                              },
                              child: const Text(
                                "Sign Up",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

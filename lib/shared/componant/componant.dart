// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, dead_code

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

void navigatorPushAndReblace(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
    (Route<dynamic> route) => false);

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType textInputType,
        required String labelText,
        required Icon prefixIcon,
        IconButton? suffixIcon,
        bool obscure = false,
        void Function(String)? onFieldSubmeitted,
        void Function(String)? onChange,
        String? Function(String?)? validator}) =>
    TextFormField(
      onFieldSubmitted: onFieldSubmeitted,
      obscureText: obscure,
      validator: validator,
      controller: controller,
      onChanged: onChange,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        label: Text("${labelText}"),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );

Widget defaultButton(
        {required String text, required void Function()? function}) =>
    Container(
      width: double.infinity,
      child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
    );

navigatTo(context, Widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}





void showToast({
  required String message,
  required toast state,
  required String title,
  required BuildContext context,
  Function() ? confirmFunction,   
}) =>
    CoolAlert.show(
   context: context,
   title: title,
   onConfirmBtnTap: confirmFunction,
   confirmBtnText: "ok",
   onCancelBtnTap: () => Navigator.pop(context),
   type: choseToast(state),
   text: message,
);

enum toast{
  success,warning,error
}



 choseToast(toast state){
  switch(state){
    case toast.success : return  CoolAlertType.success;
    break;
    case toast.error : return CoolAlertType.error;
    break;
    case toast.warning : return CoolAlertType.warning;
    break;  
  }
}

////Sign Out
/*
defaultButton(
        text: 'Log Out',
        function: () {
          navigatorPushAndReblace(context, LoginScreen());
          CacheHelper.removeData(key: 'token');
        };*/




        
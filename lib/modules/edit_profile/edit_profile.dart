import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/styles/Icons.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        emailController.text = AppCubit.get(context).model!.email;
        nameController.text = AppCubit.get(context).model!.name;
        phoneController.text = AppCubit.get(context).model!.phone;
        bioController.text = AppCubit.get(context).model!.bio;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile Edit",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: TextButton(
                  onPressed: () {
                    
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                if(state is UserInfoLoadingState)
                  const RefreshProgressIndicator(),
                Container(
                  height: 260.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(10.0),
                                  topEnd: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    AppCubit.get(context).model!.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey[300],
                                child: IconButton(
                                  onPressed: () {
                                   
                                  },
                                  icon:const Icon(
                                    IconBroken.Camera,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 65.0,
                            backgroundColor: Colors.blueGrey,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                AppCubit.get(context).model!.image,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[300],
                            child: IconButton(
                              onPressed: () {
                                
                              },
                              icon:const Icon(
                                IconBroken.Camera,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefixIcon: const Icon(
                            IconBroken.User,
                          ),
                          validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email Address";
                          }
                        },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          textInputType: TextInputType.text,
                          labelText: "Name",
                          prefixIcon: const Icon(
                            IconBroken.User,
                          ),
                          validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                        },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          controller: bioController,
                          textInputType: TextInputType.text,
                          labelText: "Bio",
                          prefixIcon: const Icon(
                            IconBroken.Info_Circle,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: "Phone",
                          prefixIcon: Icon(
                            IconBroken.Call,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

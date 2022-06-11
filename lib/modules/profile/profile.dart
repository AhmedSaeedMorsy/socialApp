import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/styles/Icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                                borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(10.0),
                                  topEnd: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: cubit.backgroundCoverImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).getCoverImage();
                                  },
                                  icon: const Icon(
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
                            backgroundColor: Colors.blueGrey[300],
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: cubit.backgroundProfileImage(),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: const Icon(
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
                Text(
                  AppCubit.get(context).model!.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppCubit.get(context).model!.bio,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 14.0,
                      ),
                ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  Row(
                    children: [
                      if(state is ProfileImagePickedSuccessState)
                        Expanded(
                        child: defaultButton(
                          text: "update Profile Image",
                          function: () {
                            cubit.uploadProfileImage(
                              name: cubit.model!.name,
                              email: cubit.model!.email,
                              phone: cubit.model!.phone,
                              bio: cubit.model!.bio,
                              uId: cubit.model!.uId,
                              cover: cubit.model!.cover,
                            );
                          },
                        ),
                      ),
                      if(state is CoverImagePickedSuccessState)
                        Expanded(
                        child: defaultButton(
                          text: "update cover Image",
                          function: () {
                            cubit.uploadCoverImage(
                              name: cubit.model!.name,
                              email: cubit.model!.email,
                              phone: cubit.model!.phone,
                              bio: cubit.model!.bio,
                              uId: cubit.model!.uId,
                              image: cubit.model!.image,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  if(state is UpdateProfileInfoLoadingState)
                    const RefreshProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "100",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Post",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 16.0,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "150",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16.0),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text("Photos",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 16.0)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "10k",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16.0),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text("Followers",
                                style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 16.0,
                                        )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "256",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text("Following",
                                style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 16.0,
                                        )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance.subscribeToTopic("request");
                        },
                        child: Text(
                          "Add Photo",
                          style: TextStyle(color: Colors.black87, fontSize: 18.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigatTo(context, EditProfile());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

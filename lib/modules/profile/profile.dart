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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 260.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius:const BorderRadiusDirectional.only(
                            topStart: Radius.circular(10.0),
                            topEnd: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                AppCubit.get(context).model!.cover,
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundColor: Colors.blueGrey[300],
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                           AppCubit.get(context).model!.image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                 AppCubit.get(context).model!.name,
                style:const TextStyle(
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
                      onPressed: () {},
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
        );
      },
    );
  }
}

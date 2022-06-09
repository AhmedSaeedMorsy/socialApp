import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/styles/Icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilderRec(
          condition: AppCubit.get(context).posts.isNotEmpty,
          builder: (context) {
            return Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(context,AppCubit.get(context).posts[index],index),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5.0),
                    itemCount: AppCubit.get(context).posts.length,
                  ),
                ),
              ],
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostItem(BuildContext context, PostModel model,index) => Card(
        elevation: 20.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      model.image,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              Text(
                                model.name,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 10.0),
                              const Icon(
                                Icons.check_circle,
                                size: 18.0,
                                color: Colors.blueAccent,
                              )
                            ],
                          ),
                        ),
                        Text(
                          model.dateTime,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                model.text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  fontSize: 16.0,
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: Wrap(
              //     children: [
              //       Container(
              //         height: 25.0,
              //         child: MaterialButton(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           minWidth: 1.0,
              //           onPressed: () {},
              //           child: const Text(
              //             "#Flutter",
              //             style: TextStyle(color: Colors.blueAccent),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 25.0,
              //         child: MaterialButton(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           minWidth: 1.0,
              //           onPressed: () {},
              //           child: const Text(
              //             "#Flutter_Development",
              //             style: TextStyle(color: Colors.blueAccent),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (model.postImage != "")
                Container(
                  width: double.infinity,
                  height: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          model.postImage,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${AppCubit.get(context).likes[index]}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amberAccent,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "0 comment",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      AppCubit.get(context).model!.image,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      "write comment",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppCubit.get(context).likesPost(AppCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Like",
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

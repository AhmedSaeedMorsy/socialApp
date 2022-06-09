import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/styles/Icons.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Post",
                style: TextStyle(color: Colors.white)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    if (cubit.postImage != null) {
                      cubit.uploadPostImage(
                        name: cubit.model!.name,
                        dateTime: DateTime.now().toString(),
                        text: textController.text,
                        image: cubit.model!.image,
                        uId: cubit.model!.uId,
                      );
                      
                    } else {
                      cubit.createPost(
                        name: cubit.model!.name,
                        dateTime: DateTime.now().toString(),
                        text: textController.text,
                        image: cubit.model!.image,
                        uId: cubit.model!.uId,
                        postImage: ""
                      );
                      
                    }
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    const Padding(
                      padding:  EdgeInsets.all(10.0),
                      child:  LinearProgressIndicator(),
                    ),
                  
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          AppCubit.get(context).model!.image,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          AppCubit.get(context).model!.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: textController,
                    minLines: 22,maxLines: 30,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "What is on your mind",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(10.0)),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage!),
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
                                cubit.removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                                color: Colors.white,
                              ),
                              Text(
                                "Add Photo",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            "# tags",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

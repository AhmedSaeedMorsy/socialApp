import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/shared/constant.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/styles/Icons.dart';

class ChatDetails extends StatelessWidget {
  UserModel? model;
  var messageController = TextEditingController();
  ChatDetails({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    model!.image,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  model!.name,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          body: ConditionalBuilderRec(
            condition: AppCubit.get(context).chat.isNotEmpty,
            fallback: (context) => const Center(
              child: const Center(child: CircularProgressIndicator()),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        // return Center(
                        //   child: Text(AppCubit.get(context).chat[index].dateTime),
                        // );
                        return SizedBox(
                          height: 15.0,
                        );
                      },
                      itemCount: AppCubit.get(context).chat.length,
                      itemBuilder: (context, index) {
                        if (AppCubit.get(context).chat[index].senderId != uId)
                          return buildRecieverMessageItem(
                              AppCubit.get(context).chat[index]);
                        return buildSenderMessageItem(
                            AppCubit.get(context).chat[index]);
                      },
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadiusDirectional.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Write your message ",
                                  border: InputBorder.none),
                              controller: messageController,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 50.0,
                          width: 70.0,
                          child: MaterialButton(
                            onPressed: () {
                              AppCubit.get(context).sendMessage(
                                  dateTime: DateTime.now().toString(),
                                  message: messageController.text,
                                  senderId: AppCubit.get(context).model!.uId,
                                  recieverId: model!.uId);
                              messageController.text = "";
                            },
                            child: const Icon(IconBroken.Message),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRecieverMessageItem(ChatModel model) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent[100],
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(4.0),
            topStart: Radius.circular(4.0),
            bottomEnd: Radius.circular(4.0),
          ),
        ),
        child: Text(
          model.message,
        ),
      ),
    );
  }

  Widget buildSenderMessageItem(ChatModel model) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(4.0),
            topStart: Radius.circular(4.0),
            bottomStart: Radius.circular(4.0),
          ),
        ),
        child: Text(
          model.message,
        ),
      ),
    );
  }
}

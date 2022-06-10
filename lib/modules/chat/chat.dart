import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildUsersItem(AppCubit.get(context).allUsers[index],context),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  width: 1.0,
                ),
            itemCount: AppCubit.get(context).allUsers.length);
      },
    );
  }

  Widget buildUsersItem(UserModel model,context) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).getMessage(recieverId: model.uId);
        navigatTo(context, ChatDetails(model: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                model.image,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

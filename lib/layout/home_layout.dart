import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/styles/Icons.dart';
import 'package:tab_container/tab_container.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/cubit/app-cubit/cubit.dart';
import 'package:social_app/shared/cubit/app-cubit/states.dart';
import 'package:social_app/shared/cubit/login_cubit/cubit.dart';

class HomeLayOut extends StatelessWidget {
  const HomeLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Redes sociales",
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Search,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Notification,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: ConditionalBuilderRec(
            condition: AppCubit.get(context).model != null,
            builder: (context) {
              return TabContainer(
                color: Colors.blueGrey[300],
                children: AppCubit.get(context).screen,
                isStringTabs: false,
                tabs: const [
                  Icon(
                    IconBroken.Home,
                    size: 25.0,
                  ),
                  Icon(
                    IconBroken.User1,
                    size: 25.0,
                  ),
                  Icon(
                    IconBroken.Chat,
                    size: 25.0,
                  ),
                  Icon(
                    IconBroken.Profile,
                    size: 25.0,
                  ),
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

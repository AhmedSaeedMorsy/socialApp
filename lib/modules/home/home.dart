import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/Icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => const SizedBox(height: 5.0),
            itemCount: 10,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget buildPostItem(BuildContext context) => Card(
        elevation: 20.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1654375165~exp=1654375765~hmac=a1e952e21a194faf086fa93238f5e8617442bce818c1c2b3396ce2e8587e4714&w=1060",
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
                            children: const [
                              Text(
                                "Ahmed Saeed",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.check_circle,
                                size: 18.0,
                                color: Colors.blueAccent,
                              )
                            ],
                          ),
                        ),
                        Text(
                          "January 21, 2022 at 11:00 pm",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
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
              const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  fontSize: 16.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  children: [
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        padding: const EdgeInsets.only(right: 5.0),
                        minWidth: 1.0,
                        onPressed: () {},
                        child: const Text(
                          "#Flutter",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        padding: const EdgeInsets.only(right: 5.0),
                        minWidth: 1.0,
                        onPressed: () {},
                        child: const Text(
                          "#Flutter_Development",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 240.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(
                    4.0,
                  ),
                  image: const DecorationImage(
                      image: AssetImage(
                        "assets/image/post.webp",
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
                        children: const [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "120",
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
                            "200 comment",
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
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(
                      "assets/image/profile.webp",
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
                    onTap: () {},
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

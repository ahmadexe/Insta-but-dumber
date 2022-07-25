import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Globals/globals.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/Screens/home_screen.dart';
import 'package:flutter_social/Screens/login_screen.dart';
import 'package:flutter_social/responsive/mobile_layout.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _posts = 0;
  int followers = 0;
  int following = 0;
  List posts = [];
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await Globals().getGlobals();
    posts = await getPosts(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      followers = Globals.followers;
      following = Globals.following;
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("posts").get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      if (snapshot.docs[i]["uid"] ==
          Provider.of<UserProvider>(context, listen: false).user!.uid) {
        setState(() {
          _posts++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: mobileBackgroundColor,
      ),
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl!),
                        radius: 40,
                      ),
                      Expanded(
                        child: counts("Posts", _posts.toString()),
                      ),
                      Expanded(
                        child: counts("Followers", followers.toString()),
                      ),
                      Expanded(
                        child: counts("Following", following.toString()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(user.username),
                  Text(user.bio),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[900],
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          child: const Icon(Icons.person_add),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[900],
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(const LoginScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[900],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: const Text(
                        "Log out",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // FutureBuilder(
                  //     future:
                  //         FirebaseFirestore.instance.collection('posts').get(),
                  //     builder: ((context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //       return Expanded(
                  //         child: GridView.builder(
                  //             physics: const ScrollPhysics(),
                  //             gridDelegate:
                  //                 const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisSpacing: 1,
                  //               mainAxisSpacing: 1,
                  //               crossAxisCount: 3,
                  //             ),
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder: (context, index) {
                  //               return snapshot.data!.docs[index]
                  //                           .data()['uid'] ==
                  //                       user.uid
                  //                   ? Container(
                  //                       height:
                  //                           MediaQuery.of(context).size.height /
                  //                               5,
                  //                       width:
                  //                           MediaQuery.of(context).size.width /
                  //                               3.3,
                  //                       child: Card(
                  //                         child: Image.network(
                  //                           snapshot.data!.docs[index]
                  //                               .data()['postUrl'],
                  //                           fit: BoxFit.fill,
                  //                         ),
                  //                       ),
                  //                     )
                  //                   : Container(child: Text('.', style: TextStyle(color: mobileBackgroundColor),),);
                  //             }),
                  //       );
                  //     }))


                  Expanded(
                          child: GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                crossAxisCount: 3,
                              ),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.3,
                                        child: Card(
                                          child: Image.network(
                                            posts[index],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                              }),
                        )
                ],
              ),
            ),
    );
  }
}




counts(String field, String number) {
  return Column(
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        field,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}

Future<List<String>> getPosts(String userId) async {
  List<String> posts = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await firestore.collection("posts").get();
  for (int i = 0; i < snapshot.docs.length; i++) {
    if (snapshot.docs[i]['uid'] == userId) {
      posts.add(snapshot.docs[i]['postUrl']);
    }
  }
  return posts;
}
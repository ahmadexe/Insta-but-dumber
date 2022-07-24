import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/responsive/mobile_layout.dart';
import 'package:flutter_social/responsive/responsive_layout_screen.dart';
import 'package:flutter_social/responsive/web_layout.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final snap;
  const Profile({super.key, required this.snap});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _posts = 0;
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("posts").get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      if (snapshot.docs[i]["uid"] == widget.snap["uid"]) {
        setState(() {
          _posts++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(widget.snap['username']),
        backgroundColor: mobileBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['photoUrl']),
                  radius: 40,
                ),
                Expanded(
                  child: counts("Posts", _posts.toString()),
                ),
                Expanded(
                  child: counts("Followers", widget.snap['followers'].length.toString()),
                ),
                Expanded(
                  child: counts("Following", widget.snap['following'].length.toString()),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.snap['username']),
            Text(widget.snap['bio']),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueAccent,
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
                      "Follow",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(Icons.person_add),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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

            const SizedBox(height: 40),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          crossAxisCount: 3,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return snapshot.data!.docs[index].data()['uid'] == widget.snap['uid']?
                           Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Card(
                              child: Image.network(
                                snapshot.data!.docs[index].data()['postUrl'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                          :
                          Container(
                          );
                        }),
                  );
                }))
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
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        field,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}

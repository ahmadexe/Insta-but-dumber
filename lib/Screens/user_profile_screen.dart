import 'package:flutter/material.dart';
import 'package:flutter_social/Screens/home_screen.dart';
import 'package:flutter_social/responsive/mobile_layout.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
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
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                  radius: 40,
                ),
                Expanded(
                  child: counts("Posts", '25'),
                ),
                Expanded(
                  child: counts("Followers", '205'),
                ),
                Expanded(
                  child: counts("Following", '2500'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Username"),
            const Text("This is a bio"),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 30,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[900],
              ),
              child: Text("Edit Profile", style: TextStyle(fontSize: 16),),
            ),
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

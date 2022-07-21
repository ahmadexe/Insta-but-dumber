import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(onPressed: (){}, icon: Icon(Icons.upload))
    // );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
          title: Text("Add Post"),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ))
          ]),
    );
  }
}

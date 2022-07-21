import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file; 
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Make a post"),
            children: <Widget>[
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _descriptionController = TextEditingController();
    ModelUser? user = Provider.of<UserProvider>(context).user;

    return _file == null? Center(
      child: IconButton(onPressed: (){_selectImage(context);}, icon: Icon(Icons.upload))
    )
    :
    Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          title: Text("Add Post"),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ))
          ]),

      //? Body portion

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl!),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write a caption...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                  width: 45,
                  height: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )),
              SizedBox(width: 8),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}

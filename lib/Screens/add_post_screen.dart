import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/Services/firestore_methods.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController _descriptionController = TextEditingController();

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

  void postImage(
    String uid,
    String username,
    String profImage
  ) async {
    try{
      String res = await FirestoreMethods().uploadPhoto(_descriptionController.text.toString(), _file!, uid, username, profImage);
      if (res == 'Success') {
        Get.snackbar("Success", "Post created successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            borderColor: Colors.green,
            borderWidth: 2,
            colorText: Colors.white,
            icon: const Icon(Icons.done, color: Colors.white)
            );
      }
      else {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            borderColor: Colors.red,
            borderWidth: 2,
            colorText: Colors.white,
            icon: const Icon(Icons.error, color: Colors.white)
            );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            borderColor: Colors.red,
            borderWidth: 2,
            colorText: Colors.white,
            icon: const Icon(Icons.error, color: Colors.white)
            );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {postImage(user!.uid, user.username, user.photoUrl!);},
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

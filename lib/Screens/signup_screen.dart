import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_social/Screens/login_screen.dart';
import 'package:flutter_social/Services/authentications.dart';
import 'package:flutter_social/Widgets/text_field_input.dart';
import 'package:flutter_social/responsive/mobile_layout.dart';
import 'package:flutter_social/responsive/responsive_layout_screen.dart';
import 'package:flutter_social/responsive/web_layout.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  signUp(
      {required String email,
      required String password,
      required String username,
      required String bio}) async {
    setState(() {
      _isLoading = true;
    });
    String result = await Authentications().signUp(
        email: email,
        password: password,
        username: username,
        bio: bio,
        file: _image!);
    if (result == 'A verification email has been sent to your email address') {
      Get.snackbar("Success", result,
          backgroundColor: Colors.teal[900],
          colorText: Colors.white,
          icon: const Icon(Icons.check, color: Colors.white),
          snackPosition: SnackPosition.TOP);
      Get.to(ResponsiveLayout(
          mobileLayout: MobileLayout(), webLayout: WebLayout()));
    } else {
      Get.snackbar("Error", result,
          backgroundColor: Colors.red[900],
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.TOP);
      Get.to(LoginScreen());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(flex: 1, child: Container()),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              height: 54,
              color: primaryColor,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png"),
                      ),
                Positioned(
                    bottom: -8,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo))),
              ],
            ),
            const SizedBox(height: 20),
            TextFieldInput(
              textEditingController: emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            TextFieldInput(
              textEditingController: passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            TextFieldInput(
              textEditingController: bioController,
              hintText: 'Enter your Bio',
              textInputType: TextInputType.text,
              isPassword: false,
            ),
            const SizedBox(height: 20),
            TextFieldInput(
              textEditingController: usernameController,
              hintText: 'Enter your Username',
              textInputType: TextInputType.text,
              isPassword: false,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                Get.snackbar("Waiting", "Please wait...",
                    backgroundColor: Colors.purple[900],
                    colorText: Colors.white,
                    icon: const Icon(Icons.timelapse, color: Colors.white),
                    snackPosition: SnackPosition.TOP);
                signUp(
                    email: emailController.text.toString().trim(),
                    password: passwordController.text.toString().trim(),
                    username: usernameController.text.toString().trim(),
                    bio: bioController.text.toString().trim());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: blueColor),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : const Text("Sign up"),
              ),
            ),
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () {
                    Get.to(const LoginScreen());
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
}

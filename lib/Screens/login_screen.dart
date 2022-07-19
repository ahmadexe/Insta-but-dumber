import 'package:flutter/material.dart';
import 'package:flutter_social/Screens/signup_screen.dart';
import 'package:flutter_social/Widgets/text_field_input.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [

              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                height: 64,
                color: primaryColor,
              ),
              const SizedBox(height: 40),
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
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: ShapeDecoration(shape: 
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), color: blueColor),
                  child: const Text("Log in"),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {Get.to(const SignupScreen());},
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 12,)
            ],
          ),
        )
      ),
    );
  }
}
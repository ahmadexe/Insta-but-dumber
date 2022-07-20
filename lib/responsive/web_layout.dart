import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: user != null? Text(user.username) : const CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:provider/provider.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Text("this is web")
      ),
       bottomNavigationBar: CupertinoTabBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
            backgroundColor: primaryColor,   
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
            backgroundColor: primaryColor
          ),
        ],
      ),
    );
  }
}
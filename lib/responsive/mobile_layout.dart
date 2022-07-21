import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/Screens/add_post_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {

  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: PageView(
        children: [
          Text(" Home "),
          Text(" Search "),
          AddPost(),
          Text(" favs "),
          Text(" profile "),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _page == 0? Colors.white : secondaryColor,),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search , color: _page == 1? Colors.white : secondaryColor,),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: _page == 2? Colors.white : secondaryColor,),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: _page == 3? Colors.white : secondaryColor,),
            label: "",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _page == 4? Colors.white : secondaryColor,),
            label: "",
            backgroundColor: primaryColor
          ),
        ],
        onTap: (page) {
          navigationTapped(page);
        },
      ),
    );
  }
}
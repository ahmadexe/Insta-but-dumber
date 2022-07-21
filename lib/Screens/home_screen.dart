import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor, height: 30,),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.send))],
        backgroundColor: mobileBackgroundColor,
      ),
    );
  }
}
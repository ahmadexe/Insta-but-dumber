import 'package:flutter/material.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/utils/dimentions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout(
      {super.key, required this.mobileLayout, required this.webLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webLayout;
      } else {
        return widget.mobileLayout;
      }
    });
  }
}

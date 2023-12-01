import 'package:flutter/material.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key,required this.webScreenLayout,required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  void addData()async{
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  Widget build(BuildContext context) {
    return LayoutBuilder
    (builder: (context, constraints) {
      if(constraints.maxWidth>webScreenSize){
     // for web
     return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
      //for phones

    },);
  }
}
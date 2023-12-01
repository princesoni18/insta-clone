import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  void navigationTapped(int page){
    pageController.jumpToPage(page);
  

  }
  void onPageChanged(int page){
    setState(() {
       _page=page;
    });
  }
  String username = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),

      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,
                color: _page == 2 ? primaryColor : secondaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_rounded,
                color: _page == 3 ? primaryColor : secondaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor),
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

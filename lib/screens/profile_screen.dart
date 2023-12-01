import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Username"),
        centerTitle: false,

      ),

      body: ListView
      
      (

        children: [
          
        ],
      ),


    );
  }
}

import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
Usermodel? _user;
final AuthMethods _authMethods=AuthMethods();
Usermodel get  getUser=> _user!;

Future<void> refreshUser()async{
  Usermodel user=await _authMethods.getUserDetails();
  _user=user;
  notifyListeners();
}


}
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/screens/widgets/customtext.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/image_pick.dart';
import 'package:insta_clone/utils/utils.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({super.key});

  @override
  State<MySignUpScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MySignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  Uint8List? image;
  bool _isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  
  selectImage()async{
  Uint8List img = await pickImage(ImageSource.gallery);
  setState(() {
    
    image=img;
  });
  }
  void signUpUser() async {
    setState(() {
      _isLoading=true;
    });
              String res = await AuthMethods().signUpUser(
                  email: _emailcontroller.text,
                  password: _passwordcontroller.text,
                  Username: _usernamecontroller.text,
                  bio: _biocontroller.text,
                  file: image!,
                  
                  );
                  setState(() {
                    
                    _isLoading=false;
                  });
                  if(res!='success'){
                    showSnackbar(res, context);
                  }
                  
              
            }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 28),
        child: Column(children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          SvgPicture.asset(
            "assets/images/intaa.svg",
            width: 200,
            color: primaryColor,
          ),
          const SizedBox(
            height: 24,
          ),
          Stack(
            children: [
              image!=null?
              CircleAvatar(
                backgroundImage: MemoryImage(image!),
                radius: 50,
              ):const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                radius: 50,
              ),
              Positioned(
                  left: 55,
                  top: 65,
                  child: IconButton(
                      onPressed: () =>selectImage(), icon: Icon(Icons.add_a_photo_rounded)))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            hintText: "Username",
            textEditingController: _usernamecontroller,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextField(
            hintText: "Email",
            textEditingController: _emailcontroller,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextField(
            hintText: "Bio",
            textEditingController: _biocontroller,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextField(
            hintText: "Password",
            textEditingController: _passwordcontroller,
            textInputType: TextInputType.text,
            pass: true,
          ),
          const SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: ()=>signUpUser(),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child:_isLoading? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,strokeWidth: 1,
                ),
              ):const Text("Log in"),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          
          
          
          const SizedBox(height: 120,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account ?",
                style: TextStyle(fontSize: 12, color: secondaryColor),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ))
            ],
          )
        ]),
      )),
    ));
  }
}

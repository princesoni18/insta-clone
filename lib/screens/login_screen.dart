
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/screens/widgets/customtext.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';

class MyLoginScreen extends StatefulWidget {

  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _emailcontroller=TextEditingController();

  final TextEditingController _passwordcontroller=TextEditingController();
  bool isloading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  void loginUser()async{
    setState(() {
      isloading=true;
    });
    String res=await AuthMethods().logInUser(email: _emailcontroller.text, password: _passwordcontroller.text);
    setState(() {
      isloading=false;
    });
    if(res=='Success'){}
    else{
      showSnackbar(res, context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 28),
          child:  Column(
           children:[
            Flexible(child: Container(),flex: 2,),
            const SizedBox(height: 60,),
           
            SvgPicture.asset("assets/images/intaa.svg",
            width: 200,
            color: primaryColor,
            ),
            const SizedBox(height: 24,),
            CustomTextField(hintText: "Email",textEditingController: _emailcontroller,textInputType: TextInputType.emailAddress,),
            const SizedBox(height: 18,),
            CustomTextField(hintText: "Password",textEditingController: _passwordcontroller,textInputType: TextInputType.text,pass: true,),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: () =>loginUser(),
              child: Container(
                
                width: double.infinity,
                alignment: Alignment.center,

                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  color: blueColor,
                  shape:RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )),
                child:isloading? CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 1,
                ):const Text("Log in"),
                
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Forgot your login details?",style: TextStyle(fontSize: 12,color:secondaryColor),),
                TextButton(onPressed: (){}, child: const Text("Get help logging in",style: TextStyle(fontSize: 13,color: Colors.white),))
              ],
            ),
      
            
      
            const SizedBox(
              height: 25,
              child: Divider(thickness: 0.5,color:secondaryColor,),
            ),
            const SizedBox(height: 5,),
            TextButton(onPressed: (){}, child: Text("Log in with Facebook",style: TextStyle(fontSize: 15),)),
            const SizedBox(height: 100,),
            Divider(thickness: 0.5,color:secondaryColor,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Don't have an account?",style: TextStyle(fontSize: 12,color: secondaryColor),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const MySignUpScreen()));
              }, child: const Text("Sign up",style: TextStyle(fontSize: 12,color: Colors.white),))
              ],
            )
           ] 
          ),
        )),
      )
      
      
    );
  }
}
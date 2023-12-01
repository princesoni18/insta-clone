import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/firebase_options.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/responsive/mobileScreenLayout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/webScreenLayout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: DefaultFirebaseOptions.web.apiKey,
       appId: DefaultFirebaseOptions.web.appId,
        messagingSenderId: DefaultFirebaseOptions.web.messagingSenderId, 
        projectId: DefaultFirebaseOptions.web.projectId,
        storageBucket: DefaultFirebaseOptions.web.storageBucket)
    );
  }
  try{await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("firebase done");
  }catch(e){
   print("erroooooooooor $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor
        ),
      
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.active){
        if(snapshot.hasData){
          return const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout());
        }
        else if(snapshot.hasError){
          return const Center(child:  Text("Some Error Occured"),);
    
        }
        
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:  CircularProgressIndicator(color: primaryColor,),);
        }
        return const MyLoginScreen();
      }),
      
      ),
    );

  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/screens/widgets/post_card.dart';
import 'package:insta_clone/utils/colors.dart';

class MyFeed extends StatelessWidget {
  const MyFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset("assets/images/intaa.svg",color: Colors.white,height: 60,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon:Icon(Icons.messenger_outline_rounded) ),
          )
        ],
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('posts').snapshots(),
       builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
          return PostCard(snap: snapshot.data!.docs[index],);
        },);
         
       },),
    );
  }
}
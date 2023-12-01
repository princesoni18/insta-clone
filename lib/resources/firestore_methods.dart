
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List file, String description, String uid,
      String username, String profileImage) async {
    String res = "some error occured";
    try {
      String url =
          await Storagemethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Postmodel post = Postmodel(
          description: description,
          postId: postId,
          Username: username,
          datePublished: DateTime.now().toString(),
          uid: uid,
          postUrl: url,
          profileImage: profileImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = "error occured";
    }
    return res;
  }
  Future<void> likePost(String uid,String postId,List likes)async{
    try{
      if(likes.contains(uid)){
       await  _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid]),
        });
      }
      else{
        await _firestore.collection('posts').doc(postId).update({
         'likes':FieldValue.arrayUnion([uid])

        });
      }

    } catch(e){
      print(e.toString());
    }

  }
  Future<void>postComment(String postId,String text,String uid,String name,String profileImage) async{
  try{
    if(text.isNotEmpty){
      String commentId=const Uuid().v1();
       await _firestore.collection('posts').doc(postId).collection("comments").doc(commentId).set(
        {
          "profileImage":profileImage,
          "Username":name,
          'uid':uid,
          'text':text,
          "commentId":commentId,
          "datePublished":DateTime.now(),

        }
      );
    }else{
      print("text is empty");
    }


  }catch (e){
   print(e.toString());
  }
  
  }

  //deleting the post
  Future<void> deletePost(String postId) async{
    try{
    _firestore.collection('posts').doc(postId).delete();
    } catch(e){
      print (e.toString());
    }

  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Postmodel{
  final String description;
  final String postId;
  final String Username;
  final String datePublished;
  final String uid;
  final String postUrl;
  final String profileImage;
  final likes;

  Postmodel({required this.description, required this.postId, required this.Username, required this.datePublished, required this.uid, required this.postUrl, required this.profileImage,this.likes});

  



Map<String,dynamic> toJson()=>{

  'postId':postId,
  "Username":Username,
  'uid':uid,
  'description':description,
  'profileImage':profileImage,
  'likes':likes,
  'datePublished':datePublished,
  'postUrl':postUrl
};

 static Postmodel fromSnap(DocumentSnapshot snap){
  var snapshot= snap.data() as Map<String,dynamic>;

  return Postmodel(
    Username: snapshot['Username'],
    uid: snapshot['uid'],
    description: snapshot['description'],
    profileImage: snapshot['profileImage'],
    likes: snapshot['likes'],
    datePublished: snapshot['datePublished'],
    postId: snapshot['postId'],
    postUrl: snapshot['postUrl']

  );
 }

}
import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel{
  final String email;
  final String profile;
  final String Username;
  final String bio;
  final String uid;
  final List followers;
  final List following;

  Usermodel({required this.email, required this.profile, required this.Username, required this.bio, required this.uid, required this.followers, required this.following});



Map<String,dynamic> toJson()=>{

  'email':email,
  "Username":Username,
  'uid':uid,
  'bio':bio,
  'profile':profile,
  'followers':followers,
  'following':following,
};

 static Usermodel fromSnap(DocumentSnapshot snap){
  var snapshot= snap.data() as Map<String,dynamic>;

  return Usermodel(
    Username: snapshot['username'],
    uid: snapshot['uid'],
    bio: snapshot['bio'],
    profile: snapshot['profile'],
    followers: snapshot['followers'],
    following: snapshot['following'],
    email: snapshot['email']

  );
 }

}
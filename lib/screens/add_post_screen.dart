import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/image_pick.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  Uint8List? _file;
  bool isLoading=false;
  void postImage(String username, String uid, String profileImage) async {
    setState(() {
      isLoading=true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _file!, textEditingController.text, uid, username, profileImage);
          if(res=='success'){
            setState(() {
              isLoading=false;
            });
            showSnackbar("Postes", context);
            clearImage();
            
          }
          else{
            setState(() {
              isLoading=false;
            });
            showSnackbar(res, context);
          }
    } catch (e) {}
  }
  void clearImage(){
    setState(() {
      _file=null;
    });
  }

  final TextEditingController textEditingController = TextEditingController();
  _selectimage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a Photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("cancel"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  Widget build(BuildContext context) {
    final Usermodel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  _selectimage(context);
                },
                icon: Icon(Icons.upload_file)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading:
                  IconButton(onPressed:clearImage, icon: Icon(Icons.arrow_back)),
              title: Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.Username, user.uid, user.profile),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
                isLoading?const LinearProgressIndicator(
                  color: blueColor,
                ):Container(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profile),
                      radius: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                )
              ],
            ),
          );
  }
}

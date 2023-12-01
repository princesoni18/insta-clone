import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/screens/comments_screen.dart';
import 'package:insta_clone/screens/widgets/like_animation.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentlen=0;
  bool isLikeAnimating=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  void deletepost(String postId)async{
    await FirestoreMethods().deletePost(postId);

  }
  void getComments()async{
    try{
      QuerySnapshot snap= await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
   commentlen=snap.docs.length;
    }catch (e){
      showSnackbar(e.toString(), context);
    }
    setState(() {
      
    });
   
  }
  @override
  Widget build(BuildContext context) {
    final Usermodel user=Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profileImage']),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['Username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'delete',
                              ]
                                  .map((e) => InkWell(
                                        onTap: (){deletepost(widget.snap['postId']);
                                        Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          child: Text(e),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.more_vert_rounded))
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: ()async{
              await FirestoreMethods().likePost(
                user.uid,widget.snap['postId'],widget.snap['likes']
              );
              setState(() {
                isLikeAnimating=true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating?1:0,

                child: LikeAnimation(child: const Icon(Icons.favorite,color: Colors.white,size: 100,),
                 isAnimating: isLikeAnimating,
                 duration: const Duration(
                  milliseconds: 400
                 ),
                 onEnd:(){
                  setState(() {
                    isLikeAnimating=false;
                  });
                 },),
              )]
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async{
                      await FirestoreMethods().likePost(
                user.uid,widget.snap['postId'],widget.snap['likes']
              );
                      
                    },
                    icon: Icon(
                      widget.snap['likes'].contains(user.uid)? Icons.favorite:Icons.favorite_outline,
                      color: widget.snap['likes'].contains(user.uid)? Colors.red:Colors.white,
                      size: 27,
                    )),
              ),
              IconButton(
                  onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context) => CommentsScreen(
                    snap: widget.snap,
                  ),)),
                  icon: const Icon(
                    Icons.comment_outlined,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  )),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border_outlined,
                            size: 28,
                          ))))
            ],
          ),
          //description and comments
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          children: [
                        TextSpan(
                            text: widget.snap["Username"],
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: '  ${widget.snap['description']}',
                        )
                      ])),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "view all ${commentlen} comments",
                      style: TextStyle(fontSize: 14, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                       widget.snap['datePublished'].substring(0,10),
                    style: TextStyle(fontSize: 14, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

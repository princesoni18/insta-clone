import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta_clone/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUsers=false;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              icon: Icon(Icons.search_rounded),
              labelText: "Search for a user ",
            ),
            onFieldSubmitted: (String s) {
               setState(() {
                 isShowUsers=true;
               });
            },
          ),
        ),
        body:isShowUsers? FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('username',isGreaterThanOrEqualTo: textEditingController.text)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]
                                ['profile']),
                      ),
                      title: Text((snapshot.data! as dynamic).docs[index]
                          ['username']),
                    );
                  });
            }):FutureBuilder(future: FirebaseFirestore.instance.collection('posts').get(), builder: (context,snapshot){

              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              
              return MasonryGridView.builder(
                
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                 itemBuilder: (context,index)=>Padding(
                   padding: const EdgeInsets.all(6.0),
                   child: Image.network((snapshot.data! as dynamic).docs[index]['postUrl']),
                 )
                 
                  
);

            }
            ),
            
      ),
    );
  }
}

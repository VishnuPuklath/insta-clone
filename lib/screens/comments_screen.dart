import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/color.dart';
import 'package:insta_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Comments'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CommentCard(
                    snap: snapshot.data!.docs[index].data(),
                  );
                });
          }),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Row(children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                    border: InputBorder.none),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              FirestoreMethods().postComment(
                  postId: widget.snap['postId'],
                  text: _commentController.text,
                  uid: user.uid,
                  name: user.username,
                  profilePic: user.photoUrl);
              setState(() {
                _commentController.clear();
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                )),
          )
        ]),
      )),
    );
  }
}

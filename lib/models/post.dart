import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? description;
  String? uid;
  String? username;
  String? postId;
  final datePublished;
  String? postUrl;
  String? profImage;
  final likes;

  Post(
      {this.description,
      this.datePublished,
      this.likes,
      this.postId,
      this.postUrl,
      this.profImage,
      this.uid,
      this.username});

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        uid: snapshot['uid'],
        datePublished: snapshot['datePublished'],
        description: snapshot['description'],
        likes: snapshot['likes'],
        postId: snapshot['postId'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['postImage'],
        username: snapshot['username']);
  }
}

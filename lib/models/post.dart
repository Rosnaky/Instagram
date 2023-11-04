import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postURL;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "postURL": postURL,
        "profImage": profImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    return Post(
      username: snap.get("username"),
      description: snap.get("description"),
      uid: snap.get("uid"),
      postId: snap.get("postId"),
      datePublished: snap.get("datePublished"),
      postURL: snap.get("postURL"),
      profImage: snap.get("profImage"),
      likes: snap.get("likes"),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String username;
  final String uid;
  final String photoURL;
  final List following;
  final List followers;

  const User({
    required this.name,
    required this.email,
    required this.username,
    required this.uid,
    required this.following,
    required this.followers,
    required this.photoURL,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "uid": uid,
        "following": following,
        "followers": followers,
        "photoURL": photoURL,
      };

  static User fromSnap(DocumentSnapshot snap) {
    return User(
      name: snap.get("name"),
      email: snap.get("email"),
      username: snap.get("username"),
      uid: snap.get("uid"),
      following: snap.get("following"),
      followers: snap.get("followers"),
      photoURL: snap.get("photoURL"),
    );
  }
}

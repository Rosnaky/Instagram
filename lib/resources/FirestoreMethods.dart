import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/StorageMethods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String result = "Error";
    try {
      String photoURL = await StorageMethods().uploadImage("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postURL: photoURL,
          profImage: profImage,
          likes: []);

      _firestore.collection("posts").doc(postId).set(post.toJson());

      result = "Success";
    } catch (err) {
      result = err.toString();
    }

    return result;
  }
}

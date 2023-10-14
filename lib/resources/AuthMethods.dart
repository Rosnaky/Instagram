import "dart:typed_data";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:instagram_flutter/resources/StorageMethods.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String name,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          name.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        print(userCredential.user!.uid);
        print(file);
        String url = await StorageMethods().uploadImage(
          "profilePics",
          file,
          false,
        );

        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "email": email,
          "username": username,
          "name": name,
          "uid": userCredential.user!.uid,
          "followers": [],
          "following": [],
          "photoUrl": url,
        });
        res = "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid.';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Email or password cannot be empty";
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-login-credentials') {
        res = 'Wrong password or email';
      } else if (e.code == "invalid-email") {
        res = "Invalid email";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}

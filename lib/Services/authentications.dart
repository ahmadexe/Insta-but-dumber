import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentications {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String message = "An error occured";
    User? user;

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        User? user = FirebaseAuth.instance.currentUser;
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("Here 0");
        await user!.sendEmailVerification();
        print("Here 1");
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'bio': bio,
          'uid': user.uid,
          'email': email,
          'followers': [],
          'following': [],
        });
        print("Here 2");
        return "A verification email has been sent to your email address";
      } else {
        return "Please fill in all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Here 3");

        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print("Here 4");

        await user!.sendEmailVerification();
        return 'A verification email has been sent to your email address';
      } else if (e.code == 'invalid-email') {
        print("Here 5");
        return 'The email address is malformed.';
      }
    } catch (e) {
      print("Here 6");
      print(e);
    }
    print('Here 7');
    return message;
  }
}

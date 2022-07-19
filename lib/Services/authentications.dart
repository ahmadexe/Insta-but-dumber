import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Services/storage.dart';

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
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // User? user = FirebaseAuth.instance.currentUser;
        UserCredential cred =  await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        
        await cred.user!.sendEmailVerification();
      
        String? photoUrl = await Storage().uploadImageToStorage('profilePics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'bio': bio,
          'uid': cred.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        
        return "A verification email has been sent to your email address";
      } else {
        return "Please fill in all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        await user!.sendEmailVerification();
        return 'A verification email has been sent to your email address';
      } else if (e.code == 'invalid-email') {
        return 'The email address is malformed.';
      }
    } catch (e) {
      print(e);
    }
    return message;
  }
}

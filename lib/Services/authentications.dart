import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
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
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await cred.user!.sendEmailVerification();

        String? photoUrl =
            await Storage().uploadImageToStorage('profilePics', file, false);

        ModelUser userModel = ModelUser(
            username: username,
            bio: bio,
            uid: cred.user!.uid,
            email: email,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());

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

  Future<String> Login(
      {required String email, required String password}) async {
    String errorStatus = "An error occured";
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user!.emailVerified) {
        errorStatus = "Success";
      } else {
        errorStatus = "Please verify your email address";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        errorStatus =
            "The password is invalid or the user does not have a password.";
      } else if (e.code == "user-not-found") {
        errorStatus = "No user corresponding to the given email was found.";
      } else if (e.code == "user-disabled") {
        errorStatus = "The user account has been disabled by an administrator.";
      } else if (e.code == "invalid-email") {
        errorStatus = "The email address is badly formatted.";
      } else if (e.code == "too-many-requests") {
        errorStatus =
            "Too many unsuccessful login attempts. Please try again later.";
      } else if (e.code == "operation-not-allowed") {
        errorStatus = "Sign-in with email and password is not enabled.";
      }
    } catch (e) {
      print(e);
    }
    return errorStatus;
  }
}

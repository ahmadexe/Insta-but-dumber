import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelUser {
  final String username;
  final String bio;
  final String uid;
  final String email;
  final List followers;
  final List following;
  final String? photoUrl;

  ModelUser({
    required this.username,
    required this.bio,
    required this.uid,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'bio': bio,
        'uid': uid,
        'email': email,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  static ModelUser fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> snap = (doc.data() as Map<String, dynamic>);
    return ModelUser(
      username: snap['username'],
      bio: snap['bio'],
      uid: snap['uid'],
      email: snap['email'],
      followers: snap['followers'],
      following: snap['following'],
      photoUrl: snap['photoUrl'],
    );
  }
}

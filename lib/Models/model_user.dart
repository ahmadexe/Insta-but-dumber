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
}

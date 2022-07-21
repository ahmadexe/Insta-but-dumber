import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String username;
  final String caption;
  final String uid;
  final String postId;
  final String postUrl;
  final String profImg;
  final datePublished;
  final List likes;

  Post(
      {required this.username,
      required this.caption,
      required this.uid,
      required this.postId,
      required this.postUrl,
      required this.profImg,
      required this.datePublished,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'username': username,
        'caption': caption,
        'uid': uid,
        'postId': postId,
        'postUrl': postUrl,
        'profImg': profImg,
        'datePublished': datePublished,
        'likes': likes,
      };

  static Post fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> snap = (doc.data() as Map<String, dynamic>);
    return Post(
      username: snap['username'],
      uid: snap['uid'],
      caption: snap['caption'],
      postId: snap['postId'],
      postUrl: snap['postUrl'],
      profImg: snap['profImg'],
      datePublished: snap['datePublished'],
      likes: snap['likes'],
    );
  }
}

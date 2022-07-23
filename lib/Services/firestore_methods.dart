import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/Services/storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPhoto(String caption, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "An error occured";
    try {
      String postId = const Uuid().v1();
      String? postUrl =
          await Storage().uploadImageToStorage('posts', file, true);
      if (postUrl != null) {
        _firestore.collection('posts').doc(postId).set({
          'username': username,
          'caption': caption,
          'uid': uid,
          'postId': postId,
          'postUrl': postUrl,
          'profImg': profImage,
          'datePublished': DateTime.now(),
          'likes': [],
        });
        res = "Success";
        return res;
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future <void> likePost(String postId, String uid, List like) async {
    try {
    if (like.contains(uid)) {
      _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
    } catch (e) {
      print(e);
    }
  } 

  Future <void> postComment(String postId, String name, String profilePic, String text) async {
    String commentId = const Uuid().v1();
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
        'commentId': commentId,
        'name': name,
        'profilePic': profilePic,
        'text': text,
      });
      print("Comment added");
    } catch (e) {
      print(e);
    }
    
  } 

}

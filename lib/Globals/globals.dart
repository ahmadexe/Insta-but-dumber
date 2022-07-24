import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Globals {
  static int followers = 0;
  static int following = 0;
  Future<void> getGlobals() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot _snapshot = await _firestore.collection('users').get();
    for (int i = 0; i < _snapshot.docs.length; i++) {
      if (_snapshot.docs[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
        
        followers = _snapshot.docs[i]['followers'].length;
        following = _snapshot.docs[i]['following'].length;
        print(followers);
        print(following);
        break;
      }
    }
  }
}

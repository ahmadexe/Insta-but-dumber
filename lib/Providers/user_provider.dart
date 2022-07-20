import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';

class UserProvider with ChangeNotifier {
  ModelUser? _user;
  ModelUser? get user => _user;

  Future<void> refreshUser () async {
    
  }

}
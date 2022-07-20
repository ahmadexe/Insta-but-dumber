import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Services/authentications.dart';

class UserProvider with ChangeNotifier {
  ModelUser? _user;
  ModelUser? get user => _user;

  Future<void> refreshUser () async {
    ModelUser user = await Authentications().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
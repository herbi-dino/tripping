import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripping/firebase/storage.dart';
import 'package:tripping/models/user_model.dart';

class UserAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> createUser({
    required String userID,
    required String email,
    required String password,
    required String name,
    required Uint8List? avatarFile,
  }) async {
    try {
      var avtUrl = 'no avatar';

      if (avatarFile != null) {
        avtUrl = await Storage().uploadImage("profilePics", avatarFile);
      }

      var usr = UserModel(
        email: email,
        name: name,
        avatarUrl: avtUrl,
        tripList: [],
      );

      await _firestore.collection('users').doc(userID).set(usr.toJson());

      return usr;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<UserModel> readUser() async {
    var curUser = _auth.currentUser!;
    var snap = await _firestore.collection('users').doc(curUser.uid).get();

    return UserModel.fromSnapshot(snap);
  }
}

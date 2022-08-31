import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripping/api/user.api.dart';
import 'package:tripping/models/user_model.dart';

class AuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String name,
    required Uint8List? avatarFile,
  }) async {
    try {
      var cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await UserAPI().createUser(
        userID: cred.user!.uid,
        email: email,
        password: password,
        name: name,
        avatarFile: avatarFile,
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (err) {
      throw Exception(err);
    }
  }
}

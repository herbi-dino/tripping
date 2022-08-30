import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String avatarUrl;
  final List<String> tripList;

  const UserModel({
    required this.email,
    required this.name,
    required this.avatarUrl,
    required this.tripList,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'tripList': tripList,
      };

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    var usrInfo = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: usrInfo['email'],
      name: usrInfo['name'],
      avatarUrl: usrInfo['avatarUrl'],
      tripList: usrInfo['tripList'] as List<String>,
    );
  }
}

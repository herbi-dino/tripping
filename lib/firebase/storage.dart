import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
    String folderName,
    Uint8List imageFile,
  ) async {
    var picID = const Uuid().v1();
    var ref = _storage.ref().child(folderName).child(picID);

    var uploadTask = ref.putData(imageFile);
    var snap = await uploadTask;

    return await snap.ref.getDownloadURL();
  }
}

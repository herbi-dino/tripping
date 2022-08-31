import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripping/api/schedule_api.dart';
import 'package:tripping/firebase/storage_firebase.dart';
import 'package:tripping/models/destination_model.dart';
import 'package:uuid/uuid.dart';

class DestinationAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DestinationModel> createDestination(
      {required String scheduleID,
      required String name,
      required String location,
      required DateTime time,
      required double pricePerPerson,
      required Uint8List? imageFile}) async {
    try {
      var imgUrl = 'no image';
      if (imageFile != null) {
        imgUrl = await StorageFirebase().uploadImage('destPics', imageFile);
      }

      var dest = DestinationModel(
        scheduleID: scheduleID,
        name: name,
        imageUrl: imgUrl,
        location: location,
        time: time,
        pricePerPerson: pricePerPerson,
      );

      var destID = const Uuid().v1();

      await _firestore
          .collection('destinations')
          .doc(destID)
          .set(dest.toJson());

      await addDestToSchedule(destID, scheduleID);

      return dest;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<DestinationModel> readDestination(String destID) async {
    try {
      var destSnap =
          await _firestore.collection('destinations').doc(destID).get();

      return DestinationModel.fromSnapshot(destSnap);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> updateDestination(
    String destID, {
    required String name,
    required String imageUrl,
    required String location,
    required DateTime time,
    required double pricePerPerson,
  }) async {
    try {
      var oldDest = await readDestination(destID);

      var newDest = DestinationModel(
        scheduleID: oldDest.scheduleID,
        name: name,
        imageUrl: imageUrl,
        location: location,
        time: time,
        pricePerPerson: pricePerPerson,
      );

      await _firestore
          .collection('destinations')
          .doc(destID)
          .set(newDest.toJson());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> deleteDestination(String destID) async {
    try {
      var dest = await readDestination(destID);

      await removeDestFromSchedule(destID, dest.scheduleID);

      await _firestore.collection('destinations').doc(destID).delete();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<DestinationModel>> getDestinationList(String scheduleID) async {
    try {
      var destLs = <DestinationModel>[];

      var destIDLs =
          (await ScheduleAPI().readSchedule(scheduleID)).destinationList;
      for (var destID in destIDLs) {
        destLs.add(await readDestination(destID));
      }

      return destLs;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> addDestToSchedule(String destID, String scheduleID) async {
    try {
      await _firestore.collection('schedules').doc(scheduleID).update({
        'destinationList': FieldValue.arrayUnion([destID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> removeDestFromSchedule(String destID, String scheduleID) async {
    try {
      await _firestore.collection('schedules').doc(scheduleID).update({
        'destinationList': FieldValue.arrayRemove([destID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }
}

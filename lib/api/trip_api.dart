import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripping/api/schedule_api.dart';
import 'package:tripping/api/user.api.dart';
import 'package:tripping/firebase/storage.dart';
import 'package:tripping/model/trip_model.dart';
import 'package:uuid/uuid.dart';

class TripAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<TripModel> createTrip({
    required String ownerID,
    required String title,
    required String location,
    required int people,
    required DateTime startDate,
    required DateTime endDate,
    required double pricePerPerson,
    required String transport,
    required Uint8List? imageFile,
  }) async {
    try {
      var imgUrl = 'no image';

      if (imageFile != null) {
        imgUrl = await Storage().uploadImage('tripPics', imageFile);
      }

      var trip = TripModel(
        ownerID: ownerID,
        title: title,
        location: location,
        people: people,
        startDate: startDate,
        endDate: endDate,
        pricePerPerson: pricePerPerson,
        transport: transport,
        imageUrl: imgUrl,
        scheduleList: [],
      );

      var tripID = const Uuid().v1();

      await _firestore.collection('trips').doc(tripID).set(trip.toJson());

      await addTripToUser(tripID);

      return trip;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<TripModel> readTrip(String tripID) async {
    try {
      var tripSnap = await _firestore.collection('trips').doc(tripID).get();
      return TripModel.fromSnapshot(tripSnap);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> updateTrip(
    String tripID, {
    required String title,
    required String location,
    required int people,
    required DateTime startDate,
    required DateTime endDate,
    required double pricePerPerson,
    required String transport,
    required Uint8List? imageFile,
  }) async {
    try {
      var oldTrip = await readTrip(tripID);

      var imgUrl = oldTrip.imageUrl;

      if (imageFile != null) {
        imgUrl = await Storage().uploadImage('tripPics', imageFile);
      }

      var newTrip = TripModel(
        ownerID: _auth.currentUser!.uid,
        title: title,
        location: location,
        people: people,
        startDate: startDate,
        endDate: endDate,
        pricePerPerson: pricePerPerson,
        transport: transport,
        imageUrl: imgUrl,
        scheduleList: oldTrip.scheduleList,
      );

      await _firestore.collection('trips').doc(tripID).set(newTrip.toJson());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> deleteTrip(String tripID) async {
    try {
      var trip = await readTrip(tripID);

      for (var scheduleID in trip.scheduleList) {
        await ScheduleAPI().deleteSchedule(scheduleID);
      }

      await removeTripFromUser(tripID);

      await _firestore.collection('trips').doc(tripID).delete();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<TripModel>> getTripList() async {
    try {
      var tripLs = <TripModel>[];

      var tripIDLs = (await UserAPI().readUser()).tripList;
      for (var tripID in tripIDLs) {
        tripLs.add(await readTrip(tripID));
      }

      return tripLs;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<TripModel>> getTripListByLocation(String locQuery) async {
    var tripQuerySnap = await _firestore.collection('trips').get();
    var tripLs = tripQuerySnap.docs
        .map((snap) => TripModel.fromSnapshot(snap))
        .where((trip) => trip.location == locQuery);

    return tripLs.toList();
  }

  Future<void> addTripToUser(String tripID) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'tripList': FieldValue.arrayUnion([tripID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> removeTripFromUser(String tripID) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'tripList': FieldValue.arrayRemove([tripID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripping/api/destination_api.dart';
import 'package:tripping/api/trip_api.dart';
import 'package:tripping/model/schedule_model.dart';
import 'package:uuid/uuid.dart';

class ScheduleAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ScheduleModel> createSchedule({
    required String tripID,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required String review,
  }) async {
    try {
      var schedule = ScheduleModel(
        tripID: tripID,
        title: title,
        startDate: startDate,
        endDate: endDate,
        review: review,
        destinationList: [],
      );

      var scheduleID = const Uuid().v1();

      await _firestore
          .collection('schedules')
          .doc(scheduleID)
          .set(schedule.toJson());

      await addScheduleToTrip(scheduleID, tripID);

      return schedule;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<ScheduleModel> readSchedule(String scheduleID) async {
    try {
      var scheduleSnap =
          await _firestore.collection('schedules').doc(scheduleID).get();

      return ScheduleModel.fromSnapshot(scheduleSnap);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> updateSchedule(
    String scheduleID, {
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required String review,
  }) async {
    try {
      var oldSchedule = await readSchedule(scheduleID);

      var newSchedule = ScheduleModel(
        tripID: oldSchedule.tripID,
        title: title,
        startDate: startDate,
        endDate: endDate,
        review: review,
        destinationList: oldSchedule.destinationList,
      );

      await _firestore
          .collection('schedules')
          .doc(scheduleID)
          .set(newSchedule.toJson());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> deleteSchedule(String scheduleID) async {
    try {
      var schedule = await readSchedule(scheduleID);

      for (var destID in schedule.destinationList) {
        await DestinationAPI().deleteDestination(destID);
      }

      await removeScheduleFromTrip(scheduleID, schedule.tripID);

      await _firestore.collection('schedules').doc(scheduleID).delete();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<ScheduleModel>> getScheduleList(String tripID) async {
    try {
      var scheduleLs = <ScheduleModel>[];

      var scheduleIDLs = (await TripAPI().readTrip(tripID)).scheduleList;
      for (var scheduleID in scheduleIDLs) {
        scheduleLs.add(await readSchedule(scheduleID));
      }

      return scheduleLs;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> addScheduleToTrip(String scheduleID, String tripID) async {
    try {
      await _firestore.collection('schedules').doc(tripID).update({
        'scheduleList': FieldValue.arrayUnion([scheduleID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> removeScheduleFromTrip(String scheduleID, String tripID) async {
    try {
      await _firestore.collection('schedules').doc(tripID).update({
        'scheduleList': FieldValue.arrayRemove([scheduleID])
      });
    } catch (err) {
      throw Exception(err);
    }
  }
}

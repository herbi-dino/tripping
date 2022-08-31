import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  final String tripID;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String review;
  final List<String> destinationList;

  const ScheduleModel({
    required this.tripID,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.review,
    required this.destinationList,
  });

  Map<String, dynamic> toJson() => {
        'tripID': tripID,
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'review': review,
        'destinationList': destinationList,
      };

  static ScheduleModel fromSnapshot(DocumentSnapshot snap) {
    var scheduleInfo = snap.data() as Map<String, dynamic>;

    return ScheduleModel(
      tripID: scheduleInfo['tripID'],
      title: scheduleInfo['title'],
      startDate: scheduleInfo['startDate'],
      endDate: scheduleInfo['endDate'],
      review: scheduleInfo['review'],
      destinationList: scheduleInfo['destinationList'] as List<String>,
    );
  }
}

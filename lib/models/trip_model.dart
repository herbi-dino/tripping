import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String ownerID;
  final String title;
  final String location;
  final int people;
  final DateTime startDate;
  final DateTime endDate;
  final double pricePerPerson;
  final String transport;
  final String imageUrl;
  final List<String> scheduleList;

  const TripModel({
    required this.ownerID,
    required this.title,
    required this.location,
    required this.people,
    required this.startDate,
    required this.endDate,
    required this.pricePerPerson,
    required this.transport,
    required this.imageUrl,
    required this.scheduleList,
  });

  Map<String, dynamic> toJson() => {
        'ownerID': ownerID,
        'title': title,
        'location': location,
        'people': people,
        'startDate': startDate,
        'endDate': endDate,
        'pricePerPerson': pricePerPerson,
        'transport': transport,
        'imageUrl': imageUrl,
        'scheduleList': scheduleList,
      };

  static TripModel fromSnapshot(DocumentSnapshot snap) {
    var tripInfo = snap.data() as Map<String, dynamic>;

    return TripModel(
      ownerID: tripInfo['ownerID'],
      title: tripInfo['title'],
      location: tripInfo['location'],
      people: tripInfo['people'],
      startDate: tripInfo['startDate'],
      endDate: tripInfo['endDate'],
      pricePerPerson: tripInfo['pricePerPerson'],
      transport: tripInfo['transport'],
      imageUrl: tripInfo['imageUrl'],
      scheduleList: tripInfo['scheduleList'] as List<String>,
    );
  }
}

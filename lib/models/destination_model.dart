import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationModel {
  final String scheduleID;
  final String name;
  final String imageUrl;
  final String location;
  final DateTime time;
  final double pricePerPerson;

  const DestinationModel({
    required this.scheduleID,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.time,
    required this.pricePerPerson,
  });

  Map<String, dynamic> toJson() => {
        'scheduleID': scheduleID,
        'name': name,
        'imageUrl': imageUrl,
        'location': location,
        'time': time,
        'pricePerPerson': pricePerPerson,
      };

  static DestinationModel fromSnapshot(DocumentSnapshot snap) {
    var destInfo = snap.data() as Map<String, dynamic>;

    return DestinationModel(
      scheduleID: destInfo['scheduleID'],
      name: destInfo['name'],
      imageUrl: destInfo['imageUrl'],
      location: destInfo['location'],
      time: destInfo['time'],
      pricePerPerson: destInfo['pricePerPerson'],
    );
  }
}

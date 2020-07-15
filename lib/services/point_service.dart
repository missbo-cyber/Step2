import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/modules/point.dart';

class PointService {
  Stream<List<Point>> getPoints() async* {
    var snapshots = Firestore.instance.collection('points').snapshots();
    await for (var snapshot in snapshots) {
      var documents = snapshot.documents;
      List<Point> points = [];

      documents.forEach((element) {
        var point = Point.fromFirebase(element);
        points.add(point);
      });
      yield points;
    }
  }
}

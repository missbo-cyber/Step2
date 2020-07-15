import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app/modules/point_type.dart';

class Point {
  String id;
  double latitude;
  double longtitude;
  String title;
  String description;
  PointType type;
  String image;
  String imageUrl;

  Point.fromFirebase(DocumentSnapshot element) {
    this.id = element.documentID;
    var data = element.data;
    this.latitude = data['latitude'];
    this.longtitude = data['longtitude'];
    this.title = data['title'];
    this.description = data['description'];
    this.image = data['image'];
    var type = data['type'];
    if (type == 'BENCH') {
      this.type = PointType.BENCH;
    } else {
      this.type = PointType.MONUMENT;
    }
  }

  getImageUrl() async {
    this.imageUrl =
        await FirebaseStorage.instance.ref().child(this.image).getDownloadURL();
  }
}

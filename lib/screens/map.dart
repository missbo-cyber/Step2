import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:app/modules/point.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}
List<Marker> allMarkers =  [];
@override
  void initState() {
    initState();
    allMarkers.add(Marker(
  markerId:MarkerId('myMarker'),
  draggable: false,
  onTap: () {
    print('MarkerTapped');
  },
  position: LatLng(52.536766, 19.700262)
   ));
  }
class _MapPageState extends State<MapPage> {
  var _subscription;
  Completer<GoogleMapController> _controller = Completer();
  var _initialCameraPosition =
      CameraPosition(target: LatLng(52.536766, 19.700262), zoom: 15);,
      markers: Set.from(AllMarkers);,
  var _markers = Set<Marker>();
  var _myPosition;

  getMyLocation() async {
    var location = Location();
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2
    );
    location.getLocation();
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    _subscription = location.onLocationChanged.listen((myLocation) async {
      var myPosition = LatLng(myLocation.latitude, myLocation.longitude);
      if (_myPosition != myPosition) {
        setState(() {
          _myPosition = myPosition;
        });

        var googleMapController = await _controller.future;
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: myPosition, zoom: 18)));
      }
    });
  }

  @override
  void initState() {
    //getMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
  }
  addMarkers(List<Point> points) {
    if (points != null) {
      points.forEach((point) {
        Marker marker = Marker(
          markerId: MarkerId(point.id),
          position: LatLng(point.latitude, point.longtitude),
          infoWindow: InfoWindow(title: point.title, snippet: point.description)
        );
        _markers.add(marker);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<List<Point>>(
      builder: (BuildContext context, value, Widget child) {
        addMarkers(value);
        return Scaffold(
          body: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onTap: (position) {
              print(position);
            },
            onLongPress: (position) {
              print("longpress");
            },
            markers: _markers,
            mapType: MapType.normal,
            onMapCreated: (googleMapController) {
            _controller.complete(googleMapController);
            },
          ),
        );
      }
    );
  }
}

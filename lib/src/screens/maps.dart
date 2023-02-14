import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(0.000000, 109.333336);
  final Set<Marker> _marker = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: new Center(
                        child: new Text("POINT A",
                         textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                      )),
                  ));
              });
        },
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Widget button(Function() function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maps',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
            mapType: _currentMapType,
            markers: _marker,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  button(_onAddMarkerButtonPressed, Icons.add_location),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _OnBottomSheet() {}

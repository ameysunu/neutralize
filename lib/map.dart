import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapType _currentMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(40.730610, -73.935242);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Neutralize",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        body: GoogleMap(
          mapType: _currentMapType,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.map),
          onPressed: () {
            setState(() {
              _currentMapType = _currentMapType == MapType.normal
                  ? MapType.satellite
                  : MapType.normal;
            });
          },
        ),
      ),
    );
  }
}

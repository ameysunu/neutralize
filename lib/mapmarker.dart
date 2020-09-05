import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medhacks/pages/elmhurst.dart';
import 'package:medhacks/pages/prohealth.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'pages/citymd.dart';

class MapMarker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  MapType _currentMapType = MapType.normal;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAsset('images/marker.bmp');
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(40.71840805398345,
        -73.9869010448456); //CityMD Lower East Side Urgent Care - NYC
    LatLng pinPosition1 = LatLng(40.742292, -73.875076); //Elmhurst ACPNY
    LatLng pinPosition2 = LatLng(40.73835606947362,
        -73.98325324058534); //Prohealth Urgent Care Of Gramercy Park New York, NY, United States
    LatLng pinPosition3 = LatLng(40.67542654519498,
        -73.89641404151918); //AdvantageCare Physicians - East New York Medical Office
    LatLng pinPosition4 = LatLng(40.796807862194534,
        -73.96985292434694); //Northwell Health-GoHealth Urgent Care new york
    LatLng pinPosition5 = LatLng(
        40.750987667893575, -73.94004285335542); //The Floating Hospital- LIC

    String positionOne = "CityMD Lower East Side Urgent Care - NYC";
    String positionTwo = "Elmhurst ACPNY";
    String positionThree =
        "Prohealth Urgent Care Of Gramercy Park New York, NY, United States";
    String positionFour =
        "AdvantageCare Physicians - East New York Medical Office";
    String positionFive = "Northwell Health-GoHealth Urgent Care New York";
    String positionSix = "The Floating Hospital- LIC";

    CameraPosition initialLocation =
        CameraPosition(zoom: 10, bearing: 30, target: pinPosition);
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
          myLocationEnabled: true,
          markers: _markers,
          initialCameraPosition: initialLocation,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              _markers.add(Marker(
                  markerId:
                      MarkerId("CityMD Lower East Side Urgent Care - NYC"),
                  position: pinPosition,
                  infoWindow: InfoWindow(
                      title: positionOne,
                      snippet: 'COVID-19 testing center',
                      onTap: () {
                        _popupDialogOne(context);
                      }),
                  icon: pinLocationIcon));

              _markers.add(Marker(
                  markerId: MarkerId("Elmhurst ACPNY"),
                  position: pinPosition1,
                  infoWindow: InfoWindow(
                    title: positionTwo,
                    onTap: () {
                      _popupDialogTwo(context);
                    },
                    snippet: 'COVID-19 testing center',
                  ),
                  icon: pinLocationIcon));

              _markers.add(Marker(
                  markerId: MarkerId(
                      "Prohealth Urgent Care Of Gramercy Park New York, NY, United States"),
                  position: pinPosition2,
                  infoWindow: InfoWindow(
                    title: positionThree,
                    onTap: () {
                      _popupDialogThree(context);
                    },
                    snippet: 'COVID-19 testing center',
                  ),
                  icon: pinLocationIcon));

              _markers.add(Marker(
                  markerId: MarkerId(
                      "AdvantageCare Physicians - East New York Medical Office"),
                  position: pinPosition3,
                  infoWindow: InfoWindow(
                    title: positionFour,
                    onTap: () {
                      _popupDialogFour(context);
                    },
                    snippet: 'COVID-19 testing center',
                  ),
                  icon: pinLocationIcon));

              _markers.add(Marker(
                  markerId: MarkerId(
                      "Northwell Health-GoHealth Urgent Care New York"),
                  position: pinPosition4,
                  infoWindow: InfoWindow(
                    title: positionFive,
                    onTap: () {
                      _popupDialogFive(context);
                    },
                    snippet: 'COVID-19 testing center',
                  ),
                  icon: pinLocationIcon));

              _markers.add(Marker(
                  markerId: MarkerId("The Floating Hospital- LIC"),
                  position: pinPosition5,
                  infoWindow: InfoWindow(
                    title: positionSix,
                    onTap: () {
                      _popupDialogSix(context);
                    },
                    snippet: 'COVID-19 testing center',
                  ),
                  icon: pinLocationIcon));
            });
          },
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

void _popupDialogOne(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionOne = "CityMD Lower East Side Urgent Care - NYC";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionOne',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 138 Delancey St, New York, NY 10002, United States.\n\nPhone: +1 212-609-2541',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.citymd.com/urgent-care-locations/ny/manhattan/delancey/031';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CityMD()),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//Elmhurst ACPNY
void _popupDialogTwo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionTwo = "Elmhurst ACPNY";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionTwo',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 86-15 Queens Blvd, Queens, NY 11373, United States.\n\nPhone: +17188996600',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.acpny.com/find-a-provider/locations/elmhurst-medical-office';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Elmhurst()),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//Prohealth Urgent Care Of Gramercy Park New York, NY, United States
void _popupDialogThree(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionTwo =
            "Prohealth Urgent Care Of Gramercy Park New York, NY, United States";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionTwo',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 291 3rd Ave, New York, NY 10010, United States.\n\nPhone: +1 646-609-3403',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.prohealthcare.com/?o=PHNY:NPS:OC_9.1_2020:YEXT:OC:GEN:20811CAD15:n_a:n_a:n_a:n_a:n_a';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Prohealth()),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//AdvantageCare Physicians - East New York Medical Office
void _popupDialogFour(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionFour =
            "AdvantageCare Physicians - East New York Medical Office";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionFour',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 101 Pennsylvania Ave, Brooklyn, NY 11207, United States.\n\nPhone: +1 646-680-4227',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.acpny.com/find-a-provider/locations/east-new-york-medical-office';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.citymd.com/urgent-care-locations/ny/manhattan/delancey/031';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//Northwell Health-GoHealth Urgent Care new york
void _popupDialogFive(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionFour = "Northwell Health-GoHealth Urgent Care New York";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionFour',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 2628 Broadway, New York, NY 10025, United States.\n\nPhone: +1 212-897-1992',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.gohealthuc.com/nyc/manhattan/w-100th?utm_source=gmb&utm_medium=organic';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.citymd.com/urgent-care-locations/ny/manhattan/delancey/031';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//The Floating Hospital- LIC
void _popupDialogSix(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        String positionFour = "The Floating Hospital- LIC";
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        '$positionFour',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Address: 41 43rd St, Queens, NY 11101, United States.\n\nPhone: +1 718-784-2240',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Website',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.thefloatinghospital.org/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                          child: RaisedButton(
                              color: Colors.white54,
                              child: Text(
                                'Book',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onPressed: () async {
                                const url =
                                    'https://www.citymd.com/urgent-care-locations/ny/manhattan/delancey/031';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

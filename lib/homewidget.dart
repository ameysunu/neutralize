import 'package:flutter/material.dart';
import 'package:medhacks/user.dart';
import 'mapmarker.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    MapMarker(),
    User(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Colors.white),
              title: new Text(
                'Home',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person, color: Colors.white),
              title: new Text(
                'User',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

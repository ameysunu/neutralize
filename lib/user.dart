import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhacks/homewidget.dart';
import 'pages/advantagecare.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance.document('users/Alisha').get();
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                          backgroundColor: Colors.white54,
                          child: Image.network("${user?.photoUrl}")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user?.displayName}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18),
                        ),
                        Text(
                          "${user?.email}",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "My Bookings",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Card(
                      color: Colors.grey[700],
                      child: FutureBuilder(
                        future: getUserInfo(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 20, 10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "Name: " +
                                                snapshot.data.data["name"] +
                                                "\nHospital: " +
                                                snapshot.data.data["hospital"] +
                                                "\nBooking Date: " +
                                                snapshot.data.data["date"] +
                                                "\nTime: " +
                                                snapshot.data.data["time"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Text("No data");
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                    onTap: () {
                      _popUpDialog(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _popUpDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Do you want to delete your booking?",
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          content: RaisedButton(
              color: Colors.black,
              child: Text(
                "Yes",
                style: TextStyle(fontFamily: "Poppins", color: Colors.white),
              ),
              onPressed: () {
                deleteRecord();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeWidget()),
                );
              }),
        );
      });
}

void deleteRecord() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  firestoreInstance.collection("users").document('Alisha').updateData({
    "name": "null",
    "age": "null",
    "date": "null",
    "hospital": "null"
  }).then((_) {
    print("success!");
  });
}

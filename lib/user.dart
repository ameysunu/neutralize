import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhacks/homewidget.dart';
import 'package:medhacks/symptoms.dart';
import 'pages/advantagecare.dart';

final sympController = TextEditingController();
final travelController = TextEditingController();
final exposeController = TextEditingController();

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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.lightbulb,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Symptom();
                  },
                ),
              ),
            ),
          ],
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
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text(
                        "The below questions, will help you get immediate assistance, depending on your answers but however are not mandatory to answer.",
                        style: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Text(
                      "Mention any specific symptoms",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: sympController,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                        decoration: new InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white54,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                          hintText: 'Headache, cough, cold etc.',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: Text(
                        "Have you travelled outside the US within 14 days? If yes mention country(s).",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: travelController,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                        decoration: new InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white54,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                          hintText: 'China, Israel, Italy etc.',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: Text(
                        "Have you been in contact with anyone who has COVID-19? If yes, do mention your exposure. ",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: exposeController,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                        decoration: new InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white54,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                          hintText: 'Yes or No',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 5),
                      child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                          color: Colors.white,
                          onPressed: () {
                            newRecord();
                            _submitDialog(context);
                          }),
                    ),
                  ],
                ),
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

void _submitDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Submit responses?",
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          content: RaisedButton(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                ),
              ],
            ),
            onPressed: () {
              clearText();
              Navigator.pop(context);
            },
          ),
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

void newRecord() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  firestoreInstance.collection("users").document('Survey').updateData({
    "symptoms": sympController.text,
    "travel": travelController.text,
    "exposure": exposeController.text,
  }).then((_) {
    print("success!");
  });
}

clearText() {
  sympController.clear();
  travelController.clear();
  exposeController.clear();
}

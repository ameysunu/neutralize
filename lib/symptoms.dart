import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhacks/homewidget.dart';
import 'package:medhacks/pages/advantagecare.dart';

Future<DocumentSnapshot> getUserInfo() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  return await Firestore.instance.document('users/Survey').get();
}

class Symptom extends StatefulWidget {
  @override
  _SymptomState createState() => _SymptomState();
}

class _SymptomState extends State<Symptom> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Symptom Responses",
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "These are your responses for the optional COVID conditions, you filled up. Do kindly be free to change them before you book your slots.",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white54,
                    fontSize: 15,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: getUserInfo(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              "Symptoms:\n" +
                                  snapshot.data.data['symptoms'] +
                                  "\n\nHave you travelled outside the US within 14 days? If yes mention country(s):\n" +
                                  snapshot.data.data['travel'] +
                                  "\n\nHave you been in contact with anyone who has COVID-19? If yes, do mention your exposure:\n" +
                                  snapshot.data.data['exposure'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 15),
                            ),
                          );
                        });
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text("No data");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  onPressed: () {
                    deleteRecord();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeWidget();
                        },
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

void deleteRecord() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  firestoreInstance.collection("users").document('Survey').updateData({
    "symptoms": "null",
    "exposure": "null",
    "travel": "null",
  }).then((_) {
    print("success!");
  });
}

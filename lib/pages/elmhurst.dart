import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final firestoreInstance = Firestore.instance;
final nameController = TextEditingController();
final ageController = TextEditingController();
final dateController = TextEditingController();

class Elmhurst extends StatefulWidget {
  @override
  _ElmhurstState createState() => _ElmhurstState();
}

class _ElmhurstState extends State<Elmhurst> {
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2080));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
            style: TextStyle(
                fontFamily: 'Poppins', color: Colors.white, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset('images/elmhurst.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "Elmhurst ACPNY",
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 35, 0),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  decoration: new InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white)),
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white54,
                        fontSize: 15),
                    labelStyle:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 35, 0),
                child: TextFormField(
                  controller: ageController,
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  decoration: new InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white)),
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white54,
                        fontSize: 15),
                    labelStyle:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                    icon: Icon(
                      Icons.accessibility_new_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'How old are you?',
                    labelText: 'Age *',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Card(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          color: Colors.white,
                          child: Text('Select Date'),
                          onPressed: () {
                            _selectDate(context);
                          }),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: dateController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText:
                                "${selectedDate.toLocal()}".split(' ')[0],
                            labelStyle: TextStyle(
                                color: Colors.white, fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Book',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dateController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                      _popup(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void createRecord() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  firestoreInstance.collection("users").document('Alisha').updateData({
    "name": nameController.text,
    "age": ageController.text,
    "date": dateController.text,
    "hospital": "Elmhurst ACPNY"
  }).then((_) {
    print("success!");
  });
}

void _popup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Do you want to confirm your booking?",
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
                createRecord();
                Navigator.of(context).pop();
              }),
        );
      });
}

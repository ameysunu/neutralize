import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medhacks/mapmarker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homewidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String userEmail;
  Future<void> getCurrentUserEmail() async {
    final user =
        await _auth.currentUser().then((value) => userEmail = value.email);
    print(user);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  Widget _signIn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset('images/google.png')),
              ),
              Text(
                "Sign in with Google",
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
            ],
          ),
          onPressed: () {
            getCurrentUserEmail();
            signInWithGoogle().whenComplete(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeWidget();
                  },
                ),
              );
            });
          }),
    );
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 20),
                child: Container(
                  height: 100,
                  child: Text(
                    "Find the nearest COVID center, without much hassle. We are right here for you.",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 350,
                    width: 350,
                    child: Image.asset('images/home.png'),
                  ),
                ),
              ),
              _signIn(),
              Center(
                child: InkWell(
                  child: Text(
                    "Have any problems logging in? Do let us know.",
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                  ),
                  onTap: () async {
                    const url =
                        'https://www.github.com/ameysunu/neutralize/issues';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

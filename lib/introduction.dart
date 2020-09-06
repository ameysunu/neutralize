import 'package:flutter/material.dart';
import 'home.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionPage(),
    );
  }
}

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle =
        TextStyle(fontSize: 19.0, fontFamily: 'Poppins', color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.black,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "Neutralize",
            body: "Get your nearest COVID testing centers.",
            image: _buildImage('first'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Booking redefined",
            body: "Book, as per your convenience.",
            image: _buildImage('second'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Symptom Survey",
            body:
                "Fill out a symptom survey and get your booking timings faster.",
            image: _buildImage('third'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "You are all ready!",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Welcome to Neutralize.", style: bodyStyle),
              ],
            ),
            image: _buildImage('fourth'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        done: const Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.white)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}

Widget _buildImage(String assetName) {
  return Align(
      child: Image.asset('images/introduction/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter);
}

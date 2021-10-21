import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_widget.dart';

class Opening extends StatefulWidget {
  final bool initialized;
  final bool error;

  const Opening({Key? key, required this.initialized, required this.error}) : super(key: key);

  @override
  _OpeningState createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(widget.error) {
      print("Failed to initialize.");
    }

    // Show a loader until FlutterFire is initialized
    if (!widget.initialized) {
      return SplashScreen(
          seconds: 3,
          navigateAfterSeconds: Home(),
          title: const Text(
            'tealth',
            style: TextStyle(
                fontFamily: 'Average Sans',
                fontSize: 20.0,
                color: Color(0xff34346E)),
          ),
          image: Image.asset('assets/tealth_logo_250.png'),
          backgroundColor: const Color(0xffCCEFFC),
          styleTextUnderTheLoader: const TextStyle(),
          photoSize: 50.0,
          loaderColor: const Color(0xff34346E));
    }

    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: Home(),
        title: const Text(
          'tealth',
          style: TextStyle(
              fontFamily: 'Average Sans',
              fontSize: 20.0,
              color: Color(0xff34346E)),
        ),
        image: Image.asset('assets/tealth_logo_250.png'),
        backgroundColor: const Color(0xffCCEFFC),
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 50.0,
        loaderColor: const Color(0xff34346E));
  }
}

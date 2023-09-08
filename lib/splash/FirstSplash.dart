import 'package:flutter/material.dart';

void main() {
  runApp(const FirstSplash());
}

class FirstSplash extends StatelessWidget {
  const FirstSplash({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white, // Set the background color to white
      ),
      home: Scaffold(
        body: FirstSplashScreen(),
      ),
    );
  }
}

class FirstSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image (test.png)
        Image.asset(
          'images/test.png', // Replace with the path to your background image
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover, // Ensure the image covers the entire screen
        ),

        // Your content on top of the background
        Positioned(
          left: 50,
          top: 163,
          child: Text(
            '내가 원하는 그림으로 화풍을 변환하고!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Apple SD Gothic Neo',
              fontWeight: FontWeight.w700,
            ),
          ),
        )
        , // Adjust the spacing as needed
            Positioned(


              // Adjust the top position as needed
            child: Image.asset(
            'images/splash.png', // Replace with the path to your image
            width: 700, // Adjust the width as needed
            height: 600, // Adjust the height as needed
            ),


    )]
    );
  }
}

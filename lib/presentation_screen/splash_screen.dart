import 'dart:async';

import 'package:firebase_db/presentation_screen/registration_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return SplashScreenWidget();
  }
}

class SplashScreenWidget extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () => navigationPage());
  }

  void navigationPage() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.45,
          ),
          Center(
            child: Hero(
              tag: "splashTag",
              child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.15,
                  child: Image.asset("assets/images/dolphin_image.png")),
            ),
          ),
        ],
      ),
    );
  }
}

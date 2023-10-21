import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import '../Views/auth.dart';
import '../Views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isLogged = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  checkLoggedIn() async {
    const storage = FlutterSecureStorage();
    String? name = await storage.read(key: 'name');
    if (name != null) {
      setState(() {
        isLogged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
          child: Lottie.asset('assets/lottie/splash_screen.json',
              animate: true,
              repeat: true,
              reverse: true, onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward().whenComplete(() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        isLogged ? const Home() : const Authenticate()),
              ));
      })),
    );
  }
}

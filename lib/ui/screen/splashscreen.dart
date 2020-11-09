import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onepay_sign_auth_dart/common/constants/app_constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

// with SingleTickerProviderStateMixin => timer animation manager
class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // create animation
  AnimationController animationController;
  Animation<double> animation;

  void navigatorSignIn() {
    Navigator.of(context).pushReplacementNamed(SIGN_IN);
  }

  // delay 3s then open sign in using timer
   startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigatorSignIn);
  }

  // create animation in initState => run one time
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = new AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: animationController,curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() { });
    startTime();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // expand all screen
        children: [
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset('assets/images/powered_by.png',height: 25,fit: BoxFit.scaleDown,),
                  )
              ],
            ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,)
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}
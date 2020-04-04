import 'package:flutter/material.dart';
import 'package:kitabu_android/Widgets/SplashScreen/footer.dart';
import 'package:kitabu_android/Widgets/SplashScreen/splashLogo.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: LogoIcon(),
              ),
            ),
            Container(
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}

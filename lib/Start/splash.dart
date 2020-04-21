import 'package:flutter/material.dart';
import 'package:kitabu_android/Widgets/SplashScreen/footer.dart';
import 'package:kitabu_android/Widgets/SplashScreen/splashLogo.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2f00ff),
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
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff01A0C7),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/ControlScreen');
                },
                child: Text("Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff2f00ff),
                Color(0xff0029FA),
                Color(0xff0A1747)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              // color: Color(0xFF005897),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                // Color(0xff0029FA)
                backgroundColor: Colors.white,
                radius: 70,
                child: LogoIcon(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 50.0),
                child: Text(
                  "Kitabu Micro-Finance",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[100],
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              RaisedButton(
                color: Color(0xFFf47f07),
                elevation: 7.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logoImage = AssetImage("assets/kitabu logo.png");
    Image image = Image(
      image: logoImage,
    );
    return Container(
      height: 100.0,
      child: image,
    );
  }
}

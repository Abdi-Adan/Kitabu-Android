import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logoImage = AssetImage("assets/images/logo.png");
    Image image = Image(
      image: logoImage,
    );
    return Column(
      children: <Widget>[
        Container(
          height: 100.0,
          child: image,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: Text(
            "Kitabu cha Deni",
            style: TextStyle(
                color: Colors.lightBlueAccent[100],
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}

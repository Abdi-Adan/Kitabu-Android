import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Provided to you by",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Kitabu Africa",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
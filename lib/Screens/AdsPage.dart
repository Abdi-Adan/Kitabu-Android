import 'package:flutter/material.dart';

class AdsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          OfferCard(),
          OfferCard(),
          OfferCard(),
          OfferCard(),
          OfferCard(),
          OfferCard(),
          OfferCard(),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 340.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        elevation: 5.0,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:kitabu_android/Screens/Debtors/Payments.dart';

class CreditorBoard extends StatefulWidget {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  CreditorBoard(this.creditorName, this.creditorDebt, this.creditorId);
  @override
  _CreditorBoardState createState() => _CreditorBoardState(creditorName, creditorDebt, creditorId);
}

class _CreditorBoardState extends State<CreditorBoard> {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  _CreditorBoardState(this.creditorName, this.creditorDebt, this.creditorId);

  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff2f00ff),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              moveBackToHomepage();
            },
          ),
          title: Text(
            "$creditorName",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            InkWell(
              splashColor: Colors.orange,
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Icon(
                  Icons.vibration,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.orange,
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: Color(0xff2f00ff),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),),
              color: Colors.white,
            ),
            tabs: <Widget>[
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Items"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Payments"),
                ),
              ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            CreditorBoard(creditorName, creditorDebt, creditorId),
            PayDashboard(creditorName, creditorDebt, creditorId),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kitabu_android/Screens/Debtors/CreditItems.dart';
import 'package:kitabu_android/Widgets/Debtors/debtorCard.dart';



class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //
  String creditorName;
  int creditorId;
  int creditorPhoneNo;
  //
  int _count = 5;
  //
  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Task Executed",
            ),
            content: Text("Creditor sucessfully added"),
            actions: <Widget>[
              FlatButton(
                child: Text("COMPLETE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context) => NewEntry(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        backgroundColor: Color(0xFFf47f07),
        tooltip: "Issue a new loan",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              title: Text(
                "New Creditor",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Creditors' Name",
                        labelStyle: TextStyle(color: Colors.black)),
                    onSaved: (value) {
                      this.creditorName = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "ID Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onSaved: (value) {
                      this.creditorId = value as int;
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf47f07),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onSaved: (value) {
                      this.creditorPhoneNo = value as int;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 5.0,
                      color: Color(0xFFf47f07),
                      onPressed: () {},
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      elevation: 5.0,
                      color: Color(0xFFf47f07),
                      onPressed: () {
                        moveBackToHomepage();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //
  ListView getLoanListView() {
    final double _balance = 300.0;
    return ListView.builder(
      itemCount: _count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 5.0,
          child: InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFf47f07),
                child: Icon(
                  Icons.play_for_work,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
              title: Text(
                "Kelvin Mulama",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Balance Remaining: $_balance",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.add_circle_outline,
                color: Color(0xFFf47f07),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DebtorDashboard()));
              },
            ),
          ),
        );
      },
    );
  }
}

class CreditorList extends StatefulWidget {
  @override
  _CreditorListState createState() => _CreditorListState();
}

class _CreditorListState extends State<CreditorList> {
  int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCreditorList(),
    );
  }
  ListView getCreditorList(){
    // TextStyle style = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext contex, int position){
        return Card(

        );
      },
    );
  }
}

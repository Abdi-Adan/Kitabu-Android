import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:kitabu_android/Screens/Debtors/CreditorBoard.dart';
import 'package:kitabu_android/models/creditor.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:kitabu_android/Widgets/Debtors/debtorCard.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  TextEditingController _nameTx = new TextEditingController();
  TextEditingController _idTx = new TextEditingController();
  TextEditingController _phoneTx = new TextEditingController();

  //
  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  Future<List<Creditor>> _fetch;

  @override
  void initState(){
    super.initState();
    _fetch = fetchCreditors();
  }

  Future<List<Creditor>> fetchCreditors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    //print(token);
    final response = await http.get(
      'https://kledgerapi.herokuapp.com/creditors',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    //print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //print(jsonResponse);
      //var creditor = jsonResponse.map((creditor) => new Creditor.fromJson(creditor)).toList();
      //print(creditor);
      return jsonResponse.map((creditor) => new Creditor.fromJson(creditor)).toList();
    } else if (response.statusCode == 404){
      throw Exception("No records Found!"); 
    } else {
      throw Exception(
            'Something went wrong!');
    }
  }

  //post creditor
  Future<http.Response> registerCreditor(String name, String idnumber, String phone) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
  return http.post(
    'https://kledgerapi.herokuapp.com/register/creditor',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
    body: jsonEncode(<String, String>{
      'full_name': name,
      'idnumber': idnumber,
      'phone': phone,
    }),
  );
}

  ListView _creditorListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].name, data[index].debt, data[index].idnumber);
        });
  }

  ListTile _tile(String name, double balance, int id) {
  return ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFf47f07),
                child: Icon(
                  Icons.play_for_work,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
              title: Text(
                "$name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Balance Remaining: $balance",
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
                        builder: (BuildContext context) => CreditorBoard(
                          name, balance, id
                        )));
              },
            );
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

  Widget buildList(BuildContext context) {
    return FutureBuilder<List<Creditor>>(
      future: _fetch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data;
          return _creditorListView(data);
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
         child: buildList(context),
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
                    controller: _nameTx,
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
                    controller: _idTx,
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
                    controller: _phoneTx,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 5.0,
                      color: Color(0xFFf47f07),
                      onPressed: () async{
                        Navigator.of(context).pop();
                        await registerCreditor(_nameTx.text, _idTx.text, _phoneTx.text);
                        _fetch = fetchCreditors();
                      },
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
}

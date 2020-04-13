import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameTx = new TextEditingController();
  TextEditingController _idTx = new TextEditingController();
  TextEditingController _phoneTx = new TextEditingController();
  TextEditingController _passTx = new TextEditingController();

  TextStyle style = TextStyle(fontSize: 20.0);

  Future<http.Response> registerUser(String name, String idnumber, String phone, String password) {
  return http.post(
    'https://kledgerapi.herokuapp.com/register/user',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'full_name': name,
      'idnumber': idnumber,
      'phone': phone,
      'password': password,
    }),
  );
}

  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
      controller: _nameTx,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Full Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final idField = TextField(
      controller: _idTx,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "ID Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final phoneField = TextField(
      controller: _phoneTx,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _passTx,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await registerUser(_nameTx.text, _idTx.text, _phoneTx.text, _passTx.text);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('idnumber', _idTx.text);
          Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (contex) => Login()));
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final toButon = RaisedButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (contex) => Login()));
        },
        child: Text("Already have an account? Sign In.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                nameField,
                SizedBox(height: 25.0),
                idField,
                SizedBox(height: 25.0),
                phoneField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                toButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

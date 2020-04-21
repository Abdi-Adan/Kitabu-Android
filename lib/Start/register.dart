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

  Future<http.Response> registerUser(
      String name, String idnumber, String phone, String password) {
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
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      controller: _nameTx,
      obscureText: false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "Full Name",
          labelStyle: TextStyle(color: Colors.black)),
    );

    final idField = TextFormField(
      keyboardType: TextInputType.number,
      controller: _idTx,
      obscureText: false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "ID Number",
          labelStyle: TextStyle(color: Colors.black)),
    );

    final phoneField = TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneTx,
      obscureText: false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "Phone Number",
          labelStyle: TextStyle(color: Colors.black)),
    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _passTx,
      obscureText: true,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.black)),
    );
    final loginButon = RaisedButton(
      elevation: 5.0,
      color: Color(0xFFf47f07),
      onPressed: () async {
        await registerUser(
            _nameTx.text, _idTx.text, _phoneTx.text, _passTx.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('idnumber', _idTx.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (contex) => Login()));
      },
      child: Text(
        "Register",
        style: TextStyle(color: Colors.white),
      ),
    );
    final toButon = RaisedButton(
      elevation: 5.0,
      color: Color(0xFFf47f07),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (contex) => Login()));
      },
      child: Text(
        "Already have an account? Sign In.",
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff2f00ff),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
      ),
    );
  }
}

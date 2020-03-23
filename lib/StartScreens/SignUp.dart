import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  //
  String _email;
  String _password;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A1747),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 200.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: TextFormField(
                // controller: emailController,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
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
                    labelText: "Enter Email Address",
                    hintText: "Enter email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white)),
                onSaved: (input) {
                  this._email = input;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: TextFormField(
                // controller: passwordController,
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password must be at least 6 characters';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
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
                    hintText: "Password Must be at least 6 characters",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white)),
                obscureText: true,
                onSaved: (input) {
                  this._password = input;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              color: Color(0xFFf47f07),
              elevation: 7.0,
              onPressed: () {
                signIn();
              },
              child: Text(
                "SignUp",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> signIn() async {
  //   final formState = _formKey.currentState;
  //   if (formState.validate()) {
  //     formState.save();
  //     FirebaseUser user = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //       email: _email,
  //       password: _password,
  //     )
  //         .then((signedInUser) {
  //       UserManagment().storeNewUser(signedInUser, context);
  //     }).catchError((e) {
  //       print(e.message);
  //     });
  //   }
  // }
}

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   //
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //
//   // TextEditingController emailController = TextEditingController();
//   // TextEditingController passwordController = TextEditingController();
//   //
//   String _email;
//   String _password;
//   //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff0A1747),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           children: <Widget>[
//             SizedBox(
//               height: 200.0,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//               child: TextFormField(
//                 // controller: emailController,
//                 validator: (input) {
//                   if (input.isEmpty) {
//                     return 'Please type a valid email';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFFf47f07),
//                           width: 1.5,
//                           style: BorderStyle.solid,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFFf47f07),
//                           width: 1.5,
//                           style: BorderStyle.solid,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                     labelText: "Enter Email Address",
//                     hintText: "Enter email",
//                     hintStyle: TextStyle(color: Colors.white),
//                     labelStyle: TextStyle(color: Colors.white)),
//                 onSaved: (input) {
//                   this._email = input;
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//               child: TextFormField(
//                 // controller: passwordController,
//                 validator: (input) {
//                   if (input.length < 6) {
//                     return 'Your password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFFf47f07),
//                           width: 1.5,
//                           style: BorderStyle.solid,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFFf47f07),
//                           width: 1.5,
//                           style: BorderStyle.solid,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                     labelText: "Password",
//                     hintText: "Password Must be at least 6 characters",
//                     hintStyle: TextStyle(color: Colors.white),
//                     labelStyle: TextStyle(color: Colors.white)),
//                 obscureText: true,
//                 onSaved: (input) {
//                   this._password = input;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             RaisedButton(
//               color: Color(0xFFf47f07),
//               elevation: 7.0,
//               onPressed: () {
//                 signIn();
//               },
//               child: Text(
//                 "SignUp",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // Future<void> signIn() async {
//   //   final formState = _formKey.currentState;
//   //   if (formState.validate()) {
//   //     formState.save();
//   //     FirebaseUser user = await FirebaseAuth.instance
//   //         .createUserWithEmailAndPassword(
//   //       email: _email,
//   //       password: _password,
//   //     )
//   //         .then((signedInUser) {
//   //       UserManagment().storeNewUser(signedInUser, context);
//   //     }).catchError((e) {
//   //       print(e.message);
//   //     });
//   //   }
//   // }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitabu_africa/Screens/root.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController secretController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;
  FirebaseUser user;
  String phoneNo;

  Future<void> verifyPhoneNumber(String phoneNumber, String code) async {
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) {
      print('Verified');
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('$authException');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      smsDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {};

    await _auth.verifyPhoneNumber(
        phoneNumber: code + phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  verifyOtp(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    FirebaseUser user = _auth.signInWithCredential(credential) as FirebaseUser;
    return user;
  }

  Future<bool> smsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => new SimpleDialog(
        title: Text(
          "SMS Verification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              alignment: Alignment.center,
              child: Text(
                  "We are sending an SMS Confirmation message to the following Number: $phoneNo")),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
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
                  labelText: "Enter the Six digit code",
                  labelStyle: TextStyle(color: Colors.black)),
              controller: smsCodeController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                elevation: 5.0,
                color: Color(0xFFf47f07),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user == null) {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyControlScreen()));
                    } else {
                      Navigator.of(context).pop();
                      verifyOtp(smsCodeController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyControlScreen()));
                    }
                  });
                },
                child: Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                elevation: 5.0,
                color: Color(0xFFf47f07),
                onPressed: () {},
                child: Text(
                  "Edit Number",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2f00ff),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            labelText: "Name",
                            hintText: 'Please type your full name',
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            labelText: "Identification Number",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                        controller: idController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                        controller: phoneNumberController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            labelText: "Secret Word",
                            labelStyle: TextStyle(color: Colors.white)),
                        controller: secretController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'By Signing-up, you agree to the terms of Service and conditions of our Privacy agreement',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        MyCheckbox(),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Remember me',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 5.0,
                        color: Color(0xFFf47f07),
                        onPressed: (){
                          verifyPhoneNumber(phoneNumberController.text, smsCodeController.text);
                        },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class MyCheckbox extends StatefulWidget {
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool _isChecked = true;
  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      activeColor: Colors.orange,
      value: _isChecked,
      onChanged: (bool value) {
        onChanged(value);
      },
    );
  }
}


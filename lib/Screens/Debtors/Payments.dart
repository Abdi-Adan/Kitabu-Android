import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PayDashboard extends StatefulWidget {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  const PayDashboard(this.creditorName, this.creditorDebt, this.creditorId);
  @override
  _PayDashboardState createState() =>
      _PayDashboardState(creditorName, creditorDebt, creditorId);
}

class _PayDashboardState extends State<PayDashboard> {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  var itemTitle;

  TextEditingController _amountTx = new TextEditingController();

  _PayDashboardState(this.creditorName, this.creditorDebt, this.creditorId);

  Future<List> fetchPayments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    final response = await http.get(
      'https://kledgerapi.herokuapp.com/$creditorId/payments',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    //print(response.body);
    //print(response.statusCode);

    if (response.statusCode == 202) {
      List jsonResponse = json.decode(response.body);
      //print(jsonResponse);
      return jsonResponse.toList();
          //.map((payment) => new Payment.fromJson(payment))
          //.toList();
    } else if (response.statusCode == 404){
      throw Exception("No records Found!"); 
    } else {
      throw Exception(
            'Something went wrong!',
      );
    }
  }


  Future<List> getData() async {
    var data = await fetchPayments();
    print(data);
    return data;
  }
  Future<List> _fetch;
   List<JsonTableColumn> columns;

  @override
  void initState() {
    super.initState();
    _fetch = fetchPayments();
    columns = [
      JsonTableColumn("id", label: "Transaction S/No"),
      JsonTableColumn("amount", label: "Amount"),
      JsonTableColumn("date", label: "Payment Date"),
    ];
  }

  Future<http.Response> addPayment(String amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    var response =  await http.post(
      'https://kledgerapi.herokuapp.com/$creditorId/pay',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode({
        'amount': amount,
      }),
    );
    print(response.body);
    return response;
  }


  Widget dataBuild(){
    return FutureBuilder<List>(
      future: _fetch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Column(
      children: <Widget>[
            JsonTable(
              data,
              columns: columns,
              showColumnToggle: true,
              paginationRowCount: 20,
            ),
          ],
    );
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
    return WillPopScope(
        onWillPop: () {
          moveBackToHomepage();
          return null;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  cardedStatus(creditorDebt),
                  dataBuild(),
                ],
              )
            ),
          ),
        )
        );
  }

  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  Widget cardedStatus(double debt){
    return Row(children: <Widget>[
      Expanded(
        child: RaisedButton(
          color: Color(0xFFf47f07),
          child: Text(
            "DUE: KES $debt",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: RaisedButton(
          color: Color(0xFFf47f07),
          child: Text(
            "Pay Back",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title: Text(
                  "PayBack Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
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
                          labelText: "Enter Amount",
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        elevation: 5.0,
                        color: Color(0xFFf47f07),
                        onPressed: () async {
                          Navigator.pop(context);
                          await addPayment(_amountTx.text);
                          _fetch = fetchPayments();
                        },
                        child: Text(
                          "Subtract",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        elevation: 5.0,
                        color: Color(0xFFf47f07),
                        onPressed: () async{
                          Navigator.pop(context);
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
      ),
    ]);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kitabu_android/models/items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DebtorDashboard extends StatefulWidget {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  const DebtorDashboard(this.creditorName, this.creditorDebt, this.creditorId);
  @override
  _DebtorDashboardState createState() =>
      _DebtorDashboardState(creditorName, creditorDebt, creditorId);
}

class _DebtorDashboardState extends State<DebtorDashboard> {
  final String creditorName;
  final double creditorDebt;
  final int creditorId;

  var itemTitle;

  TextEditingController _nameTx = new TextEditingController();
  TextEditingController _priceTx = new TextEditingController();
  TextEditingController _quantityTx = new TextEditingController();

  _DebtorDashboardState(this.creditorName, this.creditorDebt, this.creditorId);

  Future<List<Item>> fetchItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    final response = await http.get(
      'https://kledgerapi.herokuapp.com/$creditorId/items',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    //print(response.body);
    //print(response.statusCode);

    if (response.statusCode == 202) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new Item.fromJson(item))
          .toList();
    } else {
      throw Exception(
        Container(
        child: Center(
          child: Text(
            'Something went wrong!',
            style: new TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }
  }

  Future<List<Item>> _fetch;

  @override
  void initState() {
    super.initState();
    _fetch = fetchItems();
  }

  Future<http.Response> addItem(
      String name, String idnumber, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    return http.post(
      'https://kledgerapi.herokuapp.com/$creditorId/add_item',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode({
        'item_name': name,
        'price': idnumber,
        'quantity': phone,
        'borrower': creditorId,
      }),
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
              "$creditorName - Dues: $creditorDebt)",
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
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: buildList(context)
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 5.0,
            backgroundColor: Color(0xFFf47f07),
            tooltip: "Add an extra item",
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              // item add popup
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                  title: Text(
                    "Item Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
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
                            labelText: "Item Name",
                            labelStyle: TextStyle(color: Colors.black)),
                        controller: _nameTx,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
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
                            labelText: "Item Quantity",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                            controller: _quantityTx,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
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
                            labelText: "Price per Quantity",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                            controller: _priceTx,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          elevation: 5.0,
                          color: Color(0xFFf47f07),
                          onPressed: () async{
                            Navigator.pop(context);
                            await addItem(_nameTx.text, _quantityTx.text, _priceTx.text);
                            setState(() async {
                              _fetch = fetchItems();
                            });                            
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
        ));
  }

  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  Widget _itemListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].name, data[index].quantity, data[index].price);
        });
  }

  Widget _tile(String name, double quantity, double price) {
    return InkWell(
      splashColor: Color(0xFFf47f07),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {},
          subtitle: Text("Quantity: $quantity Pcs"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Unit Price: $price KES",
                style: TextStyle(color: Color(0xFFf47f07)),
              ),
              Text(
                "Total: ${price * quantity} KES",
                style: TextStyle(color: Color(0xFFf47f07)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: _fetch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Item> data = snapshot.data;
          return _itemListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class CardedStatus extends StatelessWidget {
  final double debt;
  CardedStatus(this.debt);
  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                        child: Text(
                          "Subtract",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        elevation: 5.0,
                        color: Color(0xFFf47f07),
                        onPressed: () {},
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

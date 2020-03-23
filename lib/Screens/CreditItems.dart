import 'package:flutter/material.dart';

class LoaneeDashboard extends StatefulWidget {
  @override
  _LoaneeDashboardState createState() => _LoaneeDashboardState();
}

class _LoaneeDashboardState extends State<LoaneeDashboard> {

  var itemTitle;

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
              "Creditors Name ",
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
                onTap: () {
                },
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
              child: ListView(
                children: <Widget>[
                  CardedStatus(),
                  ItemCard(),
                ],
              ),
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
                            onSaved: (itemTitle) {
                              itemTitle = itemTitle;
                            },
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
        ));
  }

  void moveBackToHomepage() {
    Navigator.pop(context);
    return null;
  }

  
}

class ItemCard extends StatelessWidget {
  final _quantity = 10;
  final _price = 50;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0xFFf47f07),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        child: ListTile(
          title: Text(
            "data",
            // itemTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {},
          subtitle: Text("Quantity: $_quantity Pcs"),
          trailing: Text(
            "Price: $_price KES",
            style: TextStyle(color: Color(0xFFf47f07)),
          ),
        ),
      ),
    );
  }
}

class CardedStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: RaisedButton(
          color: Color(0xFFf47f07),
          child: Text(
            "DUE: 123.00",
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

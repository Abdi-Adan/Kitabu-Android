import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff2f00ff),
        elevation: 5.0,
        title: Text(
          "My Dashboard", //replace text widget with image widget for youtube logo, resize image with width and height
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              height: 230.0,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Placeholder For Chart To Display Shop Loan Performance",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFf47f07),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Card(
                  color: Color(0xFFf47f07),
                  elevation: 5.0,
                  child: Container(
                    height: 70,
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "LOAN TOTAL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "2430.0 KES",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFFf47f07),
                  elevation: 5.0,
                  child: Container(
                    height: 60,
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "BALANCE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "1203.0 KES",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: RaisedButton(
                onPressed: () {},
                color: Color(0xFFf47f07),
                elevation: 5.0,
                child: Text(
                  "REMIND EVERYONE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFf47f07),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 40,
                child: Text(
                  "K",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                  ),
                ),
              )),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("Name"),
              subtitle: Text("Kelvin Mulama"),
              trailing: Icon(Icons.perm_contact_calendar),
              onTap: () {},
            ),
          ),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("ID"),
              subtitle: Text("37177280"),
              trailing: Icon(Icons.calendar_view_day),
              onTap: () {},
            ),
          ),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("Phone Number"),
              subtitle: Text("+254723073552"),
              trailing: Icon(Icons.phone),
              onTap: () {},
            ),
          ),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("LogOut"),
              trailing: Icon(Icons.lock),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

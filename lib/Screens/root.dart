import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kitabu_android/Screens/Ads/AdsPage.dart';
import 'package:kitabu_android/Screens/Debtors/Debtors.dart';


class MyControlScreen extends StatefulWidget {
  @override
  _MyControlScreenState createState() => _MyControlScreenState();
}

class _MyControlScreenState extends State<MyControlScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List<Widget> _screens = [Homepage(), AdsPage(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff2f00ff),
        elevation: 5.0,
        title: Text(
          "My Loan Book",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(),
      body: _screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.receipt,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.timeline,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Color(0xff2f00ff),
        buttonBackgroundColor: Color(0xFFf47f07),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
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
              subtitle: Text('name'),
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
              onTap: () {
                // FirebaseAuth.instance
                //     .signOut()
                //     .then((value) {
                //       Navigator.of(context).pushReplacementNamed("/landingpage");
                //     })
                //     .catchError((e) {
                //   print(e);
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:kitabu_africa/Screens/AdsPage.dart';
// import 'package:kitabu_africa/Screens/Dashboard.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:kitabu_africa/Screens/Homepage.dart';



// class MyControlScreen extends StatefulWidget {
//   @override
//   _MyControlScreenState createState() => _MyControlScreenState();
// }

// class _MyControlScreenState extends State<MyControlScreen> {
//   int _page = 0;
//   GlobalKey _bottomNavigationKey = GlobalKey();

//   List<Widget> _screens = [
//       Homepage(),
//       AdsPage(),
//       DashBoard(),
//     ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  _screens[_page],
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         index: 0,
//         height: 50.0,
//         items: <Widget>[
//           Icon(Icons.home, size: 30, color: Colors.white,),
//           Icon(Icons.receipt, size: 30, color: Colors.white,),
//           Icon(Icons.timeline, size: 30, color: Colors.white,),
//         ],
//         color:Color(0xff2f00ff),
//         buttonBackgroundColor: Color(0xFFf47f07),
//         backgroundColor: Colors.transparent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 600),
//         onTap: (index) {
//           setState(() {
//            _page = index; 
//           });
//         },
//       ),
//     );
//   }
// }






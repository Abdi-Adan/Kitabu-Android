import 'package:flutter/material.dart';

class NewEntry extends StatelessWidget {
  final double _balance = 300.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      child: InkWell(
        splashColor: Colors.deepOrange,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFf47f07),
            child: Icon(
              Icons.play_for_work,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          title: Text(
            "Kelvin Mulamwa",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Balance Remaining: $_balance",
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
                    builder: (BuildContext context) => DebtorDashboard()));
          },
        ),
      ),
    );
  }
}

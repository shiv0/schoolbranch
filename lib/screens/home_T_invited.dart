import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/screens/welcome_screen.dart';

class HomeTInvited extends StatefulWidget {
  @override
  _HomeTInvitedState createState() => _HomeTInvitedState();
}

class _HomeTInvitedState extends State<HomeTInvited> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Container(
            child: Text(
              'More',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.transit_enterexit,
                  color: Colors.black87,
                ),
                title: Text(
                  'Received',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0),
                ),
              )),
          Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.queue,
                  color: Colors.black87,
                ),
                title: Text(
                  'Accepted',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0),
                ),
              )),
          Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.close,
                  color: Colors.black87,
                ),
                title: Text(
                  'Rejected',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0),
                ),
              )),
          SizedBox(
            height: 25.0,
          ),
          Container(
            child: Card(
                color: Colors.red.shade500,
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    addStringToSF();
                  },
                  child: ListTile(
                    leading: null,
                    title: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSansPro',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginsts');
    prefs.remove('Cat');
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/Edit_BH_profile.dart';
import 'package:sk_school/screens/home_BH_profile.dart';
import 'package:sk_school/screens/welcome_screen.dart';

class Home_BH_More extends StatefulWidget {
  @override
  _Home_BH_MoreState createState() => _Home_BH_MoreState();
}

class _Home_BH_MoreState extends State<Home_BH_More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckcolor,
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
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Card(
              color: Colors.white,
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.transit_enterexit,
                  color: Colors.orange,
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
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.queue,
                  color: Colors.orange,
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
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.close,
                  color: Colors.orange,
                ),
                title: Text(
                  'Rejected',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0),
                ),
              )),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Home_BH_Profile.id);
            },
            child: Card(
                color: Colors.white,
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20.0),
                  ),
                )),
          ),
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
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }
}

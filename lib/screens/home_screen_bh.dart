import 'package:flutter/material.dart';
import 'package:sk_school/screens/home_BH_front.dart';
import 'package:sk_school/screens/home_BH_teachers.dart';
import 'package:sk_school/screens/home_T_Bh.dart';
import 'package:sk_school/screens/home_T_front.dart';
import 'package:sk_school/screens/home_T_invited.dart';
import 'package:sk_school/screens/home_T_requested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';
import 'home_BH_more.dart';

class HomeScreenBh extends StatefulWidget {
  static String id = 'Home_screen_bh';
  @override
  _HomeScreenBhState createState() => _HomeScreenBhState();
}

class _HomeScreenBhState extends State<HomeScreenBh> {
  int _currentindex = 0;
  final List<Widget> _bodychildren = [
    HomeBhFront(),
    HomeBhTeachers(),
    HomeTRequested(),
    Home_BH_More()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
//          GestureDetector(
//              onTap: () {
//                addStringToSF(); //Implement send functionality.
//              },
//              child: Center(
//                  child: Padding(
//                padding: const EdgeInsets.only(right: 8.0),
//                child: Text(
//                  'Logout',
//                  style: TextStyle(
//                      color: Colors.redAccent, fontWeight: FontWeight.w800),
//                ),
//              )))
        ],
        leading: null,
        backgroundColor: Colors.amber,
        title: Container(
          alignment: Alignment.topLeft,
          child: Text(
            'SK School',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: _bodychildren[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black45,
        onTap: OnTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text(
                'Teachers',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: new Icon(Icons.arrow_downward),
              title: new Text(
                'Received',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: new Icon(Icons.menu),
              title: new Text(
                'More',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black)
        ],
      ),
    );
  }

  void OnTabTapped(int value) {
    setState(() {
      _currentindex = value;
    });
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginsts');
    prefs.remove('Cat');
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }
}

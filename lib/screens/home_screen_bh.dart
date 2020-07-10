import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/Notify_br.dart';
import 'package:sk_school/screens/Replybybr.dart';
import 'package:sk_school/screens/home_BH_front.dart';
import 'package:sk_school/screens/home_BH_teachers.dart';
import 'package:sk_school/screens/home_T_Bh.dart';
import 'package:sk_school/screens/home_T_front.dart';
import 'package:sk_school/screens/home_T_invited.dart';
import 'package:sk_school/screens/home_T_requested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/screens/msg_list_br.dart';
import 'welcome_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, notify_screen_br.id);
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
//                addStringToSF(); //Implement send functionality.
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: GestureDetector(
                    onTap: () {
                      getNotifications();
                    },
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
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

  dart_mongo.Db db;

  void getNotifications() async {
    db = dart_mongo.Db(URL);
    try {
      await db.open().timeout(const Duration(seconds: 15));
    } on Exception catch (_) {}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Text');
    List val = await usersCollection
        .find(dart_mongo.where.eq("emailT", email))
        .toList();
    Navigator.pushNamed(context, msg_list_br.id);
  }
}

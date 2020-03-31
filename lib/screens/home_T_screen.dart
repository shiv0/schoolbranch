import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/home_T_Bh.dart';
import 'package:sk_school/screens/home_T_front.dart';
import 'package:sk_school/screens/home_T_invited.dart';
import 'package:sk_school/screens/home_T_requested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;

class Home_screen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> with WidgetsBindingObserver {
  int _currentindex = 0;
  final List<Widget> _bodychildren = [
    HomeTFront(),
    HomeTBh(),
    HomeTRequested(),
    HomeTInvited()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getUserCards();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.resumed) {
//      getUserCards();
    }
  }

  @override
  Widget build(BuildContext context) {
//    getUserCards();
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
                'Branches',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: new Icon(Icons.arrow_downward),
              title: new Text(
                'Requested',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: new Icon(Icons.menu),
              title: new Text(
                'More',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.black),
//          BottomNavigationBarItem(
//              icon: new Icon(Icons.menu),
//              title: new Text(
//                'Accepted',
//                style: TextStyle(color: Colors.black),
//              ),
//              backgroundColor: Colors.black),
//          BottomNavigationBarItem(
//              icon: new Icon(Icons.menu),
//              title: new Text(
//                'Rejected',
//                style: TextStyle(color: Colors.black),
//              ),
//              backgroundColor: Colors.black)
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

  void getUserCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email))
        .toList();
    print('huh$val');
    await db.close();
  }
}

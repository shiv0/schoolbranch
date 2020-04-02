import 'package:sk_school/screens/home_T_screen.dart';
import 'package:sk_school/screens/home_screen_bh.dart';
import 'package:sk_school/screens/login_screen.dart';
import 'package:sk_school/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
//    getdatabase();
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/ff.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'SK School',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: Material(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getdatabase() async {
    dart_mongo.Db db =
        dart_mongo.Db('mongodb://user:user123@3.6.175.16:27017/test');
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection =
        db.collection('testInsertWithObjectId');
//    await usersCollection.insertAll([
//      {'login': 'shivank', 'name': 'John Doe', 'email': 'john@doe.com'},
//      {'login': 'lsmith', 'name': 'Lucy Smith', 'email': 'lucy@smith.com'}
//    ]);
//    print('database inserted');
    List val = await usersCollection
        .find(dart_mongo.where.eq("login", 'shivank'))
        .toList();
    await db.close();

    if (val.length == 0)
      print('huh$val');
    else {
      String name = val[0]['name'];
      print('good$name');
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('loginsts');
    String cat = prefs.getString('Cat');
    if (stringValue == '1yes') {
      if (cat == '1')
        Navigator.pushReplacementNamed(context, Home_screen.id);
      else if (cat == '2')
        Navigator.pushReplacementNamed(context, HomeScreenBh.id);
    }
  }
}

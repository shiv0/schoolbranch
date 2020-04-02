import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/screens/forget_pass.dart';
import 'package:sk_school/screens/home_T_screen.dart';
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/screens/home_screen_bh.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/ff.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 55.0,
                ),
                Row(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: 95.0,
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password.',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Forget_pass.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.amber),
                      ),
                    )),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        login();
                        //Implement login functionality.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

//  void login() async {
//    Map data;
//    int rpstatus;
//    String message;
//    http.Response response = await http.post(
//      'https://webhook.site/567c4c2f-7f81-4e08-acf4-c36f191b7c07',
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//      body: jsonEncode(<String, String>{
//        'username': email,
//        'password': password,
//      }),
//    );
//    if (response.statusCode == 201) {
//      data = json.decode(response.body);
//      rpstatus = data['server'][0]['RESPONSESTATUS'];
//      message = data['server'][0]['MESSAGE'];
//      if (rpstatus == 1) {
//        Navigator.pushNamed(context, ChatScreen.id);
//      }
//    } else {
//      throw Exception('Failed to create album.');
//    }
//  }
  void login() async {
    await pr.show();

    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection =
        db.collection('testInsertWithObjectId');
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email))
        .toList();
    if (val.length == 0) {
      print('huh$val');
      await db.close();
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      dialog_show('Invalid Login', 'Enter the correct username and password.');
    } else {
      await db.close();
      pr.hide();
      String name = val[0]['password'];
      if (name == password) {
        String category = val[0]['category'];
        String email = val[0]['email'];
        if (category == '1')
          addStringToSF_T(email);
        else if (category == '2') addStringToSF_BH(email);
      } else {
        dialog_show(
            'Invalid Login', 'Enter the correct username and password.');
      }
    }
  }

  void dialog_show(String s, String t) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Colors.white,
            title: new Text(
              s,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: new Text(
                t,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Container(
                padding: EdgeInsets.only(right: 5.0),
                child: new FlatButton(
                  child: new Text(
                    "Close",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  addStringToSF_T(var email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginsts', "1yes");
    prefs.setString('Cat', "1");
    prefs.setString('email', email);
    Navigator.of(context).pushNamedAndRemoveUntil(
        Home_screen.id, (Route<dynamic> route) => false);
  }

  addStringToSF_BH(var email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginsts', "1yes");
    prefs.setString('Cat', "2");
    prefs.setString('email', email);
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreenBh.id, (Route<dynamic> route) => false);
  }
}

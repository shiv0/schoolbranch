import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen_bh.dart';
import 'home_T_screen.dart';

class Replybyteacher extends StatefulWidget {
  static String id = 'Replybyteacher';
  @override
  ReplybyteacherState createState() => ReplybyteacherState();
}

class ReplybyteacherState extends State<Replybyteacher> {
  String input_otp;
  ProgressDialog pr;
  String email_teachers, email_br, name_br, msg, status, name_T, Bname;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      email_br = arguments['emailBr'];
      name_br = arguments['name'];
      name_T = arguments['Tname'];
      status = arguments['status'];
      Bname = arguments['Bname'];
    }
    getuserdata();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to Flutter",
        home: new Material(
            child: new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/ff.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.all(30.0),
                child: new Container(
                  child: new Center(
                      child: new Column(children: [
                    new Padding(padding: EdgeInsets.only(top: 34.0)),
                    new Text(
                      'Sk School',
                      style: new TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 45.0)),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        input_otp = value; //Do something with the user input.
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter MSG',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            if (input_otp != null)
                              insertMsg();
                            else
                              dialog_show('Invalid Input',
                                  'You have not entered correctly.'); //Implement login functionality.
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Submit',
                          ),
                        ),
                      ),
                    ),
                  ])),
                ))));
  }

  dart_mongo.Db db;
  void insertMsg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email_teachers = prefs.getString('email');
    await pr.show();
    db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    await getuserdata();
    dart_mongo.DbCollection usersCollection = db.collection('Text');
    await usersCollection.update(
      await usersCollection.findOne(dart_mongo.where
          .eq("emailT", email_teachers)
          .and(dart_mongo.where.eq("msg", msg))
          .and(dart_mongo.where.eq("Bname", Bname))),
      {
        'emailT': email_teachers,
        'emailBr': email_br,
        'status': status,
        'msg': msg,
        'Bname': Bname,
        'Tname': name_T,
        'Rstatus': '0',
        'Reply': input_otp,
      },
    );
    print('database inserted');
    await db.close();
    pr.hide().then((isHidden) {
      Navigator.of(context).pop();
    });
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

  String user_name, lname, mobile;
  void getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email_teachers = prefs.getString('email');
    db = dart_mongo.Db(URL);
    try {
      await db.open().timeout(const Duration(seconds: 25));
    } on Exception catch (_) {
      pr.hide().then((isHidden) {
        dialog_show('Error', 'Some error in connecting database!');
      });
    }
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email_teachers))
        .toList();
    if (val.length == 0) {
      dialog_show('Invalid Login', 'Enter the correct username and password.');
    } else {
      user_name = val[0]['name'];
      lname = val[0]['lname'];
      mobile = val[0]['mobile'];
      if (lname == null) {
        lname = 'S';
      }
      user_name = '$user_name $lname';
      print('hey$val');
    }
  }
}

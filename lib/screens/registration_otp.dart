import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen_bh.dart';
import 'home_T_screen.dart';

class Registration_Otp extends StatefulWidget {
  static String id = 'registration_otp';
  @override
  _Registration_OtpState createState() => _Registration_OtpState();
}

class _Registration_OtpState extends State<Registration_Otp> {
  ProgressDialog pr;
  String first_name,
      last_name,
      email_id,
      mobile,
      category,
      pass,
      address,
      district,
      state,
      pin,
      otp,
      input_otp,
      qualification;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      first_name = arguments['name'];
      last_name = arguments['lname'];
      email_id = arguments['email'];
      mobile = arguments['mobile'];
      category = arguments['category'];
      pass = arguments['password'];
      qualification = arguments['qualification'];
      address = arguments['address'];
      district = arguments['district'];
      state = arguments['state'];
      pin = arguments['pin'];
      otp = arguments['otp'];
    }
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
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
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
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
                              checkOTP();
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

  void checkOTP() async {
    if (input_otp == otp) {
      await pr.show();
      dart_mongo.Db db = dart_mongo.Db(URL);
      try {
        await db.open().timeout(const Duration(seconds: 15));
      } on Exception catch (_) {
        pr.hide().then((isHidden) {
          dialog_show('Error', 'Some error in connecting database!');
        });
      }
      print('database connected');
      dart_mongo.DbCollection usersCollection = db.collection(user_coll);
      List val = await usersCollection
          .find(dart_mongo.where.eq("email", email_id))
          .toList();
      if (val.length == 0) {
        List val2 = await usersCollection
            .find(dart_mongo.where.eq("mobile", mobile))
            .toList();
        if (val2.length == 0) {
          await usersCollection.insertAll([
            {
              'name': first_name,
              'lname': last_name,
              'email': email_id,
              'mobile': mobile,
              'password': pass,
              'qualification': qualification,
              'address': address,
              'district': district,
              'state': state,
              'pin': pin,
              'category': category
            },
          ]);
          print('database inserted');
          await db.close();
          pr.hide().then((isHidden) {
            addStringToSF();
          });
        } else {
          await db.close();
          pr.hide();
          dialog_show('Already User', 'Mobile already exist.Try login');
        }
      } else {
        await db.close();
        pr.hide();
        dialog_show('Already User', 'Email already exist.Try login');
      }
    } else
      dialog_show('Incorrect OTP', 'The OTP you entered is not correct.!');
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

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginsts', "1yes");
    prefs.setString('Cat', category);
    prefs.setString('email', email_id);
    if (category == '1')
      Navigator.of(context).pushNamedAndRemoveUntil(
          Home_screen.id, (Route<dynamic> route) => false);
    else if (category == '2')
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreenBh.id, (Route<dynamic> route) => false);
  }
}

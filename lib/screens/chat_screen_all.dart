import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen_bh.dart';
import 'home_T_screen.dart';

class Chat_Screen_all extends StatefulWidget {
  static String id = 'chat_screen_all';
  @override
  _Chat_Screen_allState createState() => _Chat_Screen_allState();
}

class _Chat_Screen_allState extends State<Chat_Screen_all> {
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
    ;
  }

  void insertMsg() async {
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
    dart_mongo.DbCollection usersCollection = db.collection('Text2');
//    List val = await usersCollection
//        .find(dart_mongo.where.eq("email", email_id))
//        .toList();
//    if (val.length == 0) {
//      List val2 = await usersCollection
//          .find(dart_mongo.where.eq("mobile", mobile))
//          .toList();
//      if (val2.length == 0) {
    await usersCollection.insertAll([
      {
        'emailT': first_name,
        'emailBr': last_name,
        'status': email_id,
        'msg': mobile,
      },
    ]);
    print('database inserted');
    await db.close();
    pr.hide().then((isHidden) {});
//      } else {
//        await db.close();
//        pr.hide();
//        dialog_show('Already User', 'Mobile already exist.Try login');
//      }
//    } else {
//      await db.close();
//      pr.hide();
//      dialog_show('Already User', 'Email already exist.Try login');
//    }
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
}

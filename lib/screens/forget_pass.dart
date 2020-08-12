import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';

class Forget_pass extends StatefulWidget {
  static String id = 'forget_pass';
  @override
  _Forget_passState createState() => _Forget_passState();
}

class _Forget_passState extends State<Forget_pass> {
  String mobile;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
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
                    new Padding(padding: EdgeInsets.only(top: 14.0)),
                    new Text(
                      'Sk School',
                      style: new TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 45.0)),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        mobile = value; //Do something with the user input.
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your mobile',
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
                            checkexistings(); //Implement login functionality.
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Forgot',
                          ),
                        ),
                      ),
                    ),
                  ])),
                ))));
  }

  void checkexistings() async {
    await pr.show();
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
    List val = await usersCollection
        .find(dart_mongo.where.eq("mobile", mobile))
        .toList();
    if (val.length == 0) {
      pr.hide().then((isHidden) {
        dialog_show('Not Found!', 'The mobile does not exist.');
      });
    } else {
      pr.hide().then((isHidden) {
        dialog_show('Received', 'Your request is registered.');
      });
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
}

import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';

class AddForm extends StatefulWidget {
  static String id = 'add_form';
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String duration,
      date,
      amount,
      house,
      district,
      state,
      pincode,
      description,
      subject,
      qualification,
      email,
      mobile;
  String user_name, lname;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.green,
          textTheme: TextTheme(body1: TextStyle(color: Colors.purple)),
        ),
        home: Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              leading: null,
              backgroundColor: Colors.amber,
              title: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            body: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text("Select Subject",
                                style: TextStyle(
                                  color: Colors.black87,
                                )),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: "1",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Physics",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "2",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Chemistry",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              subject = value;
                            });
                          },
                          value: subject,
                          elevation: 2,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          isDense: true,
                          iconSize: 40.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          duration = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Duration',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          date = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Date',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          amount = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Amount',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text("Select Qualification",
                                style: TextStyle(
                                  color: Colors.black87,
                                )),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: "1",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Graduate",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "2",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Post Graduate",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              qualification = value;
                            });
                          },
                          value: qualification,
                          elevation: 2,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          isDense: true,
                          iconSize: 40.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          house = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'House No.',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          district = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'District',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          state = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'State',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          pincode = value; //Do something with the user input.
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Pin Code',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        onChanged: (value) {
                          description =
                              value; //Do something with the user input.
                        },
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Colors.amber,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            validate();
//                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ])));
  }

  void validate() {
    if (subject == null ||
        duration == null ||
        date == null ||
        amount == null ||
        qualification == null ||
        house == null ||
        district == null ||
        state == null ||
        pincode == null ||
        description == null)
      dialog_show('Incomplete Input', 'Please fill the complete details.');
    else
      submit();
  }

  dart_mongo.Db db;

  void submit() async {
    await pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    await getuserdata();
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    await usersCollection.insertAll([
      {
        'email': email,
        'name': user_name,
        'subject': subject,
        'duration': duration,
        'date': date,
        'amount': amount,
        'qualification': qualification,
        'house': house,
        'district': district,
        'state': state,
        'pincode': pincode,
        'description': description,
      },
    ]);
    print('database inserted');
    await db.close();
    pr.hide().then((isHidden) {
      Navigator.of(context).pop();
    });
  }

  void getuserdata() async {
    dart_mongo.DbCollection usersCollection =
        db.collection('testInsertWithObjectId');
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email))
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

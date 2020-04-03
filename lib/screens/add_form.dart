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
  final _formKey = GlobalKey<FormState>();

  String user_name, lname;
  DateTime selectedDate = DateTime.now();
  TextEditingController _controller;
  bool _autoValidate = false;

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    _controller = new TextEditingController(
        text: "${selectedDate.toLocal()}".split(' ')[0]);

    return MaterialApp(
//        theme: ThemeData(
//          primaryColor: Colors.blue,
//          accentColor: Colors.green,
//          textTheme: TextTheme(body1: TextStyle(color: Colors.purple)),
//        ),
        home: Scaffold(
            backgroundColor: Colors.white,
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
                  child: Form(
                    autovalidate: _autoValidate,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 25.0,
                        ),
                        DropdownButtonFormField<String>(
                          isDense: true,
                          iconSize: 20.0,
                          value: subject,
                          decoration:
                              InputDecoration(labelText: 'Select Subject'),
                          onChanged: (salutation) =>
                              setState(() => subject = salutation),
                          validator: (value) =>
                              value == null ? 'Please select' : null,
                          items: ['MR.', 'MS.']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (String value) {
                            if (value != null && value.isEmpty) {
                              // ignore: missing_return
                              return 'Field Required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            duration =
                                value; //Do something with the user input.
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Duration'),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: _controller,
                              validator: (String value) {
                                if (value != null && value.isEmpty) {
                                  // ignore: missing_return
                                  return 'Field Required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                date =
                                    value; //Do something with the user input.
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(labelText: 'Date'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (String value) {
                            if (value != null && value.isEmpty) {
                              // ignore: missing_return
                              return 'Field Required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            amount = value; //Do something with the user input.
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Amount'),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
//                        DropdownButtonFormField<String>(
//                          isDense: true,
//                          iconSize: 20.0,
//                          value: qualification,
//                          decoration: InputDecoration(
//                              labelText: 'Select Qualification'),
//                          onChanged: (salutation) =>
//                              setState(() => qualification = salutation),
//                          validator: (value) =>
//                              value == null ? 'Please select' : null,
//                          items: ['Graduate', 'Post Graduate']
//                              .map<DropdownMenuItem<String>>((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(value),
//                            );
//                          }).toList(),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
//                        TextFormField(
//                          validator: (String value) {
//                            if (value != null && value.isEmpty) {
//                              // ignore: missing_return
//                              return 'Field Required';
//                            }
//                            return null;
//                          },
//                          onChanged: (value) {
//                            house = value; //Do something with the user input.
//                          },
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(labelText: 'House No.'),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
//                        DropdownButtonFormField<String>(
//                          isDense: true,
//                          iconSize: 20.0,
//                          value: district,
//                          decoration:
//                              InputDecoration(labelText: 'Select District'),
//                          onChanged: (salutation) =>
//                              setState(() => district = salutation),
//                          validator: (value) =>
//                              value == null ? 'Please select' : null,
//                          items: ['Chinatown', 'Buona Vista']
//                              .map<DropdownMenuItem<String>>((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(value),
//                            );
//                          }).toList(),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
//                        DropdownButtonFormField<String>(
//                          isDense: true,
//                          iconSize: 20.0,
//                          value: state,
//                          decoration:
//                              InputDecoration(labelText: 'Select State'),
//                          onChanged: (salutation) =>
//                              setState(() => state = salutation),
//                          validator: (value) =>
//                              value == null ? 'Please select' : null,
//                          items: ['Central', 'East side']
//                              .map<DropdownMenuItem<String>>((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(value),
//                            );
//                          }).toList(),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
//                        TextFormField(
//                          validator: (String value) {
//                            if (value != null && value.isEmpty) {
//                              // ignore: missing_return
//                              return 'Field Required';
//                            }
//                            return null;
//                          },
//                          onChanged: (value) {
//                            pincode = value; //Do something with the user input.
//                          },
//                          keyboardType: TextInputType.number,
//                          decoration: InputDecoration(labelText: 'Pin Code'),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
                        TextFormField(
                          validator: (String value) {
                            if (value != null && value.isEmpty) {
                              // ignore: missing_return
                              return 'Field Required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            description =
                                value; //Do something with the user input.
                          },
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Description'),
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
                              if (_formKey.currentState.validate()) {
                                submit();
                              } else {
                                setState(() {
                                  _autoValidate = true;
                                });
                              }
//                            Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }

//  void validate() {
//    if (subject == null ||
//        duration == null ||
//        date == null ||
//        amount == null ||
//        qualification == null ||
//        house == null ||
//        district == null ||
//        state == null ||
//        pincode == null ||
//        description == null)
//      dialog_show('Incomplete Input', 'Please fill the complete details.');
//    else
//      submit();
//  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
        'date': "${selectedDate.toLocal()}".split(' ')[0],
        'amount': amount,
//        'qualification': qualification,
//        'house': house,
//        'district': district,
//        'state': state,
//        'pincode': pincode,
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

import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/Edit_card_T.dart';

class Card_Details_T extends StatefulWidget {
  static String id = 'card_details_T';

  @override
  _Card_Details_TState createState() => _Card_Details_TState();
}

class _Card_Details_TState extends State<Card_Details_T> {
  String duration,
      pduration = "",
      date,
      pdate = "",
      amount,
      pamount = "",
      house,
      district,
      state,
      pincode,
      description,
      pdescription = "",
      subject,
      psubject = "",
      qualification,
      email,
      mobile;
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;

  String user_name, lname;
  DateTime selectedDate = DateTime.now();
  TextEditingController _controller;
  bool _autoValidate = false;
  bool editbool = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      pdate = arguments['date'];
      pduration = arguments['duration'];
      pamount = arguments['amount'];
      pdescription = arguments['description'];
      psubject = arguments['subject'];
    }
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
                  'View Details',
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
                        Text(
                          'Subject',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        Visibility(
                          visible: false,
                          child: DropdownButtonFormField<String>(
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
                        ),
                        Visibility(
                          visible: true,
                          child: TextFormField(
                            enabled: false,
                            validator: (String value) {
                              if (value != null && value.isEmpty) {
                                // ignore: missing_return
                                return 'Field Required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              subject =
                                  value; //Do something with the user input.
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: psubject,
                                labelStyle: TextStyle(color: Colors.black87)),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Duration',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        TextFormField(
                          enabled: false,
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
                          decoration: InputDecoration(
                              hintText: pduration,
                              labelStyle: TextStyle(color: Colors.black87)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Date',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (editbool == true) _selectDate(context);
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              enabled: false,
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
                              decoration: InputDecoration(hintText: pdate),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Amount',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        TextFormField(
                          enabled: false,
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
                          decoration: InputDecoration(hintText: pamount),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Description',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        TextFormField(
                          enabled: false,
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
                          decoration: InputDecoration(hintText: pdescription),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RaisedButton(
                                  color: Colors.amber,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0,
                                            left: 0.0,
                                            top: 8.0,
                                            bottom: 8.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Edit();

//                            Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RaisedButton(
                                  color: Colors.redAccent,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0,
                                            left: 0.0,
                                            top: 8.0,
                                            bottom: 8.0),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    delete();

//                            Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }

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
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
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

  void delete() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Colors.white,
            title: new Text(
              'Delete',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: new Text(
                'Are you sure you want to permanent delete this card?',
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
              Container(
                padding: EdgeInsets.only(right: 5.0),
                child: new FlatButton(
                  child: new Text(
                    "Delete",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onPressed: () {
                    delete_confirm();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  void delete_confirm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    dart_mongo.Db db = dart_mongo.Db(URL);
    try {
      await db.open().timeout(const Duration(seconds: 25));
    } on Exception catch (_) {
      pr.hide().then((isHidden) {
        dialog_show('Error', 'Some error in connecting database!');
      });
    }
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    await usersCollection.remove(await usersCollection.findOne(dart_mongo.where
        .eq("email", email)
        .and(dart_mongo.where.eq("date", pdate))
        .and(dart_mongo.where.eq("duration", pduration))));
    print('database deleted');
    Navigator.of(context).pop();
  }

  void Edit() {
    Navigator.pushReplacementNamed(context, Edit_Card_T.id, arguments: {
      'date': pdate,
      'duration': pduration,
      'amount': pamount,
      'description': pdescription,
      'subject': psubject
    });
  }
}

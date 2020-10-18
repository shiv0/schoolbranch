import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/Edit_card_T.dart';

class Home_BH_Profile extends StatefulWidget {
  static String id = 'home_BH_profile';
  @override
  _Home_BH_ProfileState createState() => _Home_BH_ProfileState();
}

class _Home_BH_ProfileState extends State<Home_BH_Profile> {
  String paddress = '',
      address,
      pstate = '',
      state,
      district,
      pdistrict = '',
      pin,
      ppin = '',
      description,
      pdescription = '';
  List<String> state1 = [], district1 = [], district2 = [], districtlist = [];
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;

  String user_name, lname;
  DateTime selectedDate = DateTime.now();
  TextEditingController _controller;
  bool _autoValidate = false;
  bool editbool = false;
  bool display = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    getUserCards();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: null,
              backgroundColor: Colors.amber,
              title: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'View Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            body: display
                ? Stack(children: [
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
                                'Address',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              ),
                              TextFormField(
                                enabled: editbool,
                                validator: (String value) {
                                  if (value != null && value.isEmpty) {
                                    // ignore: missing_return
                                    return 'Field Required';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  address =
                                      value; //Do something with the user input.
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: address,
                                    labelStyle:
                                        TextStyle(color: Colors.black87)),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'State',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              ),
                              Visibility(
                                visible: !editbool,
                                child: TextFormField(
                                  enabled: editbool,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      // ignore: missing_return
                                      return 'Field Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    state =
                                        value; //Do something with the user input.
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: state,
                                      labelStyle:
                                          TextStyle(color: Colors.black87)),
                                ),
                              ),
                              Visibility(
                                visible: editbool,
                                child: Container(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text("Select State",
                                          style: TextStyle(
                                            color: Colors.black87,
                                          )),
                                    ),
                                    items: state1.map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: new Text(value),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        state = value;
//                                        print(state);
//                                        if (value == 'STATEab')
//                                          districtlist = district1;
//                                        else
//                                          districtlist = district2;
//                                        district = null;
                                      });
                                    },
                                    value: state,
                                    elevation: 2,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                    isDense: true,
                                    iconSize: 40.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'City',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              ),
                              Visibility(
                                visible: !editbool,
                                child: TextFormField(
                                  enabled: editbool,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      // ignore: missing_return
                                      return 'Field Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    district =
                                        value; //Do something with the user input.
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      InputDecoration(hintText: district),
                                ),
                              ),
                              Visibility(
                                visible: editbool,
                                child: Container(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text("Select City",
                                          style: TextStyle(
                                            color: Colors.black87,
                                          )),
                                    ),
                                    items: districtlist.map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: new Text(value),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        district = value;
                                      });
                                    },
                                    value: district,
                                    elevation: 2,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                    isDense: true,
                                    iconSize: 40.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Pin',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              ),
                              TextFormField(
                                enabled: editbool,
                                validator: (String value) {
                                  if (value != null && value.isEmpty) {
                                    // ignore: missing_return
                                    return 'Field Required';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  pin =
                                      value; //Do something with the user input.
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(hintText: pin),
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
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: editbool
                                            ? null
                                            : () {
                                                editbool = true;
                                                setState(() {});
//                            Navigator.of(context).pop();
                                              },
                                      ),
                                    ),
                                    Visibility(
                                      visible: editbool,
                                      child: Padding(
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
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            submit();
//                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])
                : Container(
                    child: Center(
                        child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  )))));
  }

  String email, name, password, qualification, category, mobile;
  dart_mongo.Db db;

  void getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email))
        .toList();
    if (val.length == 0) {
      dialog_show('Invalid Login', 'Enter the correct username and password.');
    } else {
      setState(() {
        address = val[0]['address'];
        state = val[0]['state'];
        district = val[0]['district'];
        name = val[0]['name'];
        lname = val[0]['lname'];
        password = val[0]['password'];
        qualification = val[0]['qualification'];
        category = val[0]['category'];
        mobile = val[0]['mobile'];
        pin = val[0]['pin'];
        display = true;
        if (state == 'STATEab')
          districtlist = district1;
        else
          districtlist = district2;
      });
      await db.close();
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

  List<String> list2, list_state_city, list_qualification = [];

  void getUserCards() async {
//    Future.delayed(Duration.zero, () {
//      pr.show();
//    });

    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
//    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('state');
    List val = await usersCollection.find().toList();
    print('huh$val');
    List<String> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String name = val[i]['sname'];
      list.add(name);
    }
    setState(() {
      if (!list.isEmpty) state1 = list;
    });
//    print('database connected');
    dart_mongo.DbCollection usersCollection2 = db.collection('city');
    List val2 = await usersCollection2.find().toList();
    print('huh$val2');
    list2 = [];
    list_state_city = [];
    for (int i = val2.length - 1; i >= 0; i--) {
      String stategot = val2[i]['state'];
      String city = val2[i]['cname'];
      list2.add(city);
      list_state_city.add(stategot);
    }
    setState(() {
      if (!list2.isEmpty) districtlist = list2;
    });
    dart_mongo.DbCollection usersCollection3 = db.collection('qualification');
    List val3 = await usersCollection3.find().toList();
    print('huh$val3');
    for (int i = val3.length - 1; i >= 0; i--) {
      String qname = val3[i]['qname'];
      list_qualification.add(qname);
    }
    setState(() {});
    await db.close();
//    pr.hide().then((isHidden) {
//      print(isHidden);
//    });
  }

  void submit() async {
    await pr.show();
    db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
    await usersCollection.update(
      await usersCollection.findOne(dart_mongo.where.eq("email", email)),
      {
        'name': name,
        'lname': lname,
        'email': email,
        'mobile': mobile,
        'password': password,
        'qualification': qualification,
        'address': address,
        'district': district,
        'state': state,
        'pin': pin,
        'category': category
      },
    );
    print('database inserted');
    await db.close();
    pr.hide().then((isHidden) {
      Navigator.of(context).pop();
    });
  }
}

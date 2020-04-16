import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_Form_BH extends StatefulWidget {
  static String id = 'add_form_bh';
  @override
  _Add_Form_BHState createState() => _Add_Form_BHState();
}

class _Add_Form_BHState extends State<Add_Form_BH> {
  String duration,
      start_date,
      end_date,
      posted_date,
      amount,
      house,
      district,
      state,
      pincode,
      description,
      subject,
      gender,
      qualification,
      email,
      mobile;
  final _formKey = GlobalKey<FormState>();

  String user_name, lname;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  DateTime now_date = DateTime.now();
  TextEditingController _controller, _controller2;
  bool _autoValidate = false;

  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    posted_date = "${now_date.toLocal()}".split(' ')[0];
    _controller = new TextEditingController(
        text: "${selectedDate1.toLocal()}".split(' ')[0]);
    _controller2 = new TextEditingController(
        text: "${selectedDate2.toLocal()}".split(' ')[0]);
    return MaterialApp(
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
                          items: ['Physics.', 'Chemistry.']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        DropdownButtonFormField<String>(
                          isDense: true,
                          iconSize: 20.0,
                          value: gender,
                          decoration:
                              InputDecoration(labelText: 'Select Gender'),
                          onChanged: (salutation) =>
                              setState(() => gender = salutation),
                          validator: (value) =>
                              value == null ? 'Please select' : null,
                          items: ['Male', 'Female']
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
                                start_date =
                                    value; //Do something with the user input.
                              },
                              keyboardType: TextInputType.text,
                              decoration:
                                  InputDecoration(labelText: 'Start Date'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate2(context);
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: _controller2,
                              validator: (String value) {
                                if (value != null && value.isEmpty) {
                                  // ignore: missing_return
                                  return 'Field Required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                end_date =
                                    value; //Do something with the user input.
                              },
                              keyboardType: TextInputType.text,
                              decoration:
                                  InputDecoration(labelText: 'End Date'),
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1)
      setState(() {
        selectedDate1 = picked;
      });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
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
    dart_mongo.DbCollection usersCollection = db.collection('BHCards');
    await usersCollection.insertAll([
      {
        'email': email,
        'name': user_name,
        'subject': subject,
        'gender': gender,
        'duration': duration,
        'start_date': "${selectedDate1.toLocal()}".split(' ')[0],
        'end_date': "${selectedDate2.toLocal()}".split(' ')[0],
        'amount': amount,
        'description': description,
        'posted_date': posted_date,
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
}

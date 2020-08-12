import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';

class Edit_BH_Profile extends StatefulWidget {
  static String id = 'home_BH_profile';
  @override
  _Edit_BH_ProfileState createState() => _Edit_BH_ProfileState();
}

class _Edit_BH_ProfileState extends State<Edit_BH_Profile> {
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
      posted_date = "",
      qualification,
      email,
      mobile;
  bool isdatechanged = false;
  var changed_date;
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;

  String user_name, lname;
  DateTime selectedDate = DateTime.now();
  DateTime now_date = DateTime.now();
  TextEditingController _controller;
  bool _autoValidate = false;
  bool editbool = false;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      pdate = arguments['date'];
      pduration = arguments['duration'];
      pamount = arguments['amount'];
      pdescription = arguments['description'];
      psubject = arguments['subject'];
    }
    if (subject == null) subject = psubject;
    date = pdate;
    posted_date = "${selectedDate.toLocal()}".split(' ')[0];
    duration = pduration;
    amount = pamount;
    description = pdescription;
    _controller =
        new TextEditingController(text: isdatechanged ? changed_date : pdate);
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
                  'Edit Details',
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
                          'Duration',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                        ),
                        TextFormField(
                          initialValue: pduration,
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
                              labelStyle: TextStyle(color: Colors.black87)),
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
                          initialValue: pamount,
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
                          decoration: InputDecoration(),
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
                          initialValue: pdescription,
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
                          decoration: InputDecoration(),
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
                                  color: Colors.grey,
                                  child: Row(
                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            right: 8.0,
//                                            left: 0.0,
//                                            top: 8.0,
//                                            bottom: 8.0),
//                                        child: Icon(
//                                          Icons.edit,
//                                          color: Colors.white,
//                                        ),
//                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Cancel",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RaisedButton(
                                  color: Colors.amber,
                                  child: Row(
                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            right: 8.0,
//                                            left: 0.0,
//                                            top: 8.0,
//                                            bottom: 8.0),
//                                        child: Icon(
//                                          Icons.close,
//                                          color: Colors.white,
//                                        ),
//                                      ),
                                      Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                    } else {
                                      setState(() {
                                        _autoValidate = true;
                                      });
                                    }
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
}

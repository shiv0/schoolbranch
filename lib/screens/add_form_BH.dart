import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

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
      mobile,
      subject_label = 'Select Subjects',
      gender_label = 'Select Gender';
  List<String> subject_list = ['Physics.', 'Chemistry.'];
  List<String> gender_list = ['Male', 'Female'];
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
                        InkWell(
                          onTap: () {
                            _showMultiSelect_subject(context);
                          },
                          child: IgnorePointer(
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              iconSize: 20.0,
                              value: subject,
                              decoration:
                                  InputDecoration(labelText: subject_label),
                              onChanged: (salutation) =>
                                  setState(() => subject = salutation),
                              items: subject_list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        InkWell(
                          onTap: () {
                            _showMultiSelect_gender(context);
                          },
                          child: IgnorePointer(
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              iconSize: 20.0,
                              value: gender,
                              decoration:
                                  InputDecoration(labelText: gender_label),
                              onChanged: (salutation) =>
                                  setState(() => gender = salutation),
                              items: gender_list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                                if (subject_label == 'Select Subjects' ||
                                    gender_label == 'Select Gender') {
                                  dialog_show('Incomplete Form',
                                      'Please complete all the fields.');
                                } else
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
        'subject': subject_label,
        'gender': gender_label,
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

  void _showMultiSelect_subject(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'Physics.'),
      MultiSelectDialogItem(2, 'Chemistry.'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          title: 'Select Subjects',
        );
      },
    );
    String subjects_selected =
        subject_list.elementAt(selectedValues.elementAt(0) - 1);
    for (int i = 1; i < selectedValues.length; i++) {
      subjects_selected = subjects_selected +
          ',' +
          subject_list.elementAt(selectedValues.elementAt(i) - 1);
    }
    print(subjects_selected);
    setState(() {
      subject_label = subjects_selected;
    });
  }

  void _showMultiSelect_gender(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'Male'),
      MultiSelectDialogItem(2, 'Female'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          title: 'Select Gender',
        );
      },
    );
    String gender_selected =
        gender_list.elementAt(selectedValues.elementAt(0) - 1);
    for (int i = 1; i < selectedValues.length; i++) {
      gender_selected = gender_selected +
          ',' +
          gender_list.elementAt(selectedValues.elementAt(i) - 1);
    }
    print(gender_selected);
    setState(() {
      gender_label = gender_selected;
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
}

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog(
      {Key key, this.items, this.initialSelectedValues, this.title})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;
  String title;

  @override
  State<StatefulWidget> createState() =>
      _MultiSelectDialogState<V>(title: title);
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();
  String title;
  _MultiSelectDialogState({this.title});

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}

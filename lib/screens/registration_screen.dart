import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/home_T_screen.dart';
import 'package:sk_school/screens/home_screen_bh.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String first_name, last_name, email_id, mobile, category, pass, cnfpass;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/ff.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 45.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'SK School',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                onChanged: (value) {
                  first_name = value; //Do something with the user input.
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) {
                  last_name = value; //Do something with the user input.
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) {
                  email_id = value; //Do something with the user input.
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email id',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) {
                  mobile = value; //Do something with the user input.
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Mobile No.',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text("Please select category",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: "1",
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Teacher",
                        ),
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: "2",
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Branch Head",
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      category = value;
                    });
                  },
                  value: category,
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
                  pass = value; //Do something with the user input.
                },
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) {
                  cnfpass = value; //Do something with the user input.
                },
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      validate(); //Implement registration functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }

  void validate() {
    if (first_name == null ||
        last_name == null ||
        email_id == null ||
        mobile == null ||
        category == null ||
        pass == null ||
        cnfpass == null)
      dialog_show('Incomplete Input', 'Please fill the complete details.');
    else if (email_id.contains('@') &&
        email_id.endsWith('.com')) if (mobile.length == 10) if (pass == cnfpass)
      register();
    else
      dialog_show('Password mismatched', 'Password Mismatched.');
    else
      dialog_show('Invalid Mobile', 'Please enter a valid mobile number.');
    else
      dialog_show('Invalid Email', 'Please enter a valid email.');
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

  void register() async {
    await pr.show();
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection =
        db.collection('testInsertWithObjectId');
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
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginsts', "1yes");
    prefs.setString('Cat', category);
    if (category == '1')
      Navigator.pushReplacementNamed(context, Home_screen.id);
    else if (category == '2')
      Navigator.pushReplacementNamed(context, HomeScreenBh.id);
  }
}

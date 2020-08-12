import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_school/screens/chat_screen_br.dart';
import 'package:sk_school/screens/chat_screen_teachers.dart';
import 'package:sk_school/screens/payment.dart';

class Card_Details_T_BH extends StatefulWidget {
  static String id = 'card_details_T_bh';
  @override
  _Card_Details_T_BHState createState() => _Card_Details_T_BHState();
}

class _Card_Details_T_BHState extends State<Card_Details_T_BH> {
  String email = "",
      subject = "",
      duration = "",
      date = "",
      amount = "",
      description = "",
      name = "",
      lname = "",
      mobile = "",
      qualification = "",
      address = "",
      state = "",
      district = "",
      psubject = "",
      pamount = "",
      pduration = "",
      pdate = "",
      pdescription = "",
      pemail = "",
      pstatus = "",
      status = "",
      pin = "";
  ProgressDialog pr;
  bool display = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      pemail = arguments['email'];
      psubject = arguments['subject'];
      pduration = arguments['duration'];
      pdate = arguments['date'];
      pamount = arguments['amount'];
      pdescription = arguments['description'];
      pstatus = arguments['status'];
      if (name == "") getUserData();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome to Flutter",
      home: Scaffold(
        backgroundColor: bckcolor,
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
        body: display
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
//                                          Icons.edit,
//                                          color: Colors.white,
//                                        ),
//                                      ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Call",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            updatestatus('called');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                "Message",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            updatestatus('Messaged');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
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
                                "Invite",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            updatestatus('Invited');
                          },
                        ),
                      ),
                    ]),
                    Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        elevation: 6,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Name:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Last Name:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        lname,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Email id:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Mobile:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        mobile,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Qualification:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        qualification,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Address:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        address,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'State:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        state,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'District:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        district,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Pin:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        pin,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Subject:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        subject,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Duration:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        duration,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Available Date:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Amount:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        amount,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Description:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        description,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 85,
                                        child: Text(
                                          'Status:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 0.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Payment.id);
                      },
                      child: Card(
                          color: Colors.white,
                          elevation: 8,
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.payment,
                              color: Colors.orange,
                            ),
                            title: Text(
                              'Make a Payment',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 20.0),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 35,
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              )),
      ),
    );
  }

  void getUserData() async {
//    WidgetsBinding.instance.addPostFrameCallback((_) async {
//      await pr.show();
//    });

    dart_mongo.Db db = dart_mongo.Db(URL);
    try {
      await db.open().timeout(const Duration(seconds: 25));
    } on Exception catch (_) {
      pr.hide().then((isHidden) {
        dialog_show('Error', 'Some error in connecting database!');
      });
    }
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection(user_coll);
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", pemail))
        .toList();
    if (val.length != 0) {
      await db.close();

      setState(() {
        name = val[0]['name'];
        lname = val[0]['lname'];
        mobile = val[0]['mobile'];
        qualification = val[0]['qualification'];
        address = val[0]['address'];
        district = val[0]['district'];
        state = val[0]['state'];
        pin = val[0]['pin'];
        subject = psubject;
        duration = pduration;
        date = pdate;
        amount = pamount;
        description = pdescription;
        email = pemail;
        status = pstatus;
        display = true;
        print(name);
//        Future.delayed(Duration(seconds: 3)).then((value) {
//          pr.hide().whenComplete(() {
//            print(pr.isShowing());
//          });
//        });
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

  String user_name;
  dart_mongo.Db db;

  void updatestatus(String s) async {
    db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    await getuserdata();
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    await usersCollection.update(
      await usersCollection.findOne(dart_mongo.where
          .eq("email", email)
          .and(dart_mongo.where.eq("date", pdate))
          .and(dart_mongo.where.eq("duration", pduration))),
      {
        'email': email,
        'name': user_name,
        'subject': subject,
        'duration': duration,
        'date': date,
        'amount': amount,
        'description': description,
        'state': state,
        'status': s
      },
    );
    print('database $email$email2');
    String ismessage = s == 'Messaged' ? '1' : '0';
    if (ismessage == '1') {
      Navigator.pushNamed(context, chat_screen_br.id,
          arguments: {'email': email});
    } else {
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
          'emailT': email,
          'emailBr': email2,
          'status': 'SBN',
          'msg': 'You are ' + s + ' by ' + user_name2,
          'Bname': user_name2,
          'Tname': user_name,
          'Rstatus': '1',
          'from': email2,
          'event': s,
        },
      ]);
      print('database inserted');
//      dialog_show(s, 'You ' + s + ' ' + user_name);
      await db.close();
      pr.hide().then((isHidden) {
        Navigator.of(context).pop();
      });
    }
//    dart_mongo.DbCollection usersCollection2 = db.collection('Notifications');
//    await usersCollection2.insertAll([
//      {
//        'email': email,
//        'emailfrom': email2,
//        'notification': 'You are ' + s + ' by ' + user_name2,
//        'ismessage': ismessage,
//        'message1': '',
//        'message2': '',
//      },
//    ]);
//    print('database inserted');
//    dart_mongo.DbCollection usersCollection3 = db.collection('Notify');
//    List val = await usersCollection3
//        .find(dart_mongo.where.eq("email", email))
//        .toList();
//    if (val.length == 0) {
//      await usersCollection3.insertAll([
//        {
//          'email': email,
//          'notification': '1',
//        },
//      ]);
//    } else {
//      await usersCollection.update(
//          await usersCollection.findOne(dart_mongo.where.eq("email", email)), {
//        'email': email,
//        'notification': '1',
//      });
//    }
//    print('database inserted');
//    await db.close();
//    pr.hide().then((isHidden) {
//      Navigator.of(context).pop();
//    });
  }

  String user_name2, email2;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email2 = prefs.getString('email');
      dart_mongo.DbCollection usersCollection = db.collection(user_coll);
      List val2 = await usersCollection
          .find(dart_mongo.where.eq("email", email2))
          .toList();
      if (val.length == 0) {
        dialog_show(
            'Invalid Login', 'Enter the correct username and password.');
      } else {
        user_name2 = val2[0]['name'];
        String lname2 = val2[0]['lname'];

        if (lname2 == null) {
          lname2 = 'S';
        }
        user_name2 = '$user_name2 $lname2';
      }
    }
  }
}

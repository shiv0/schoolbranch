import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:sk_school/screens/add_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sk_school/screens/card_details_T.dart';
import 'package:sk_school/screens/msg_list_br.dart';

class msg_received_Br extends StatefulWidget {
  static String id = 'msg_received_br';
  @override
  msg_received_BrState createState() => msg_received_BrState();
}

class msg_received_BrState extends State<msg_received_Br> {
  List<Choice> card_list = [];
  String email, password;
  ProgressDialog pr;
  bool display = false;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    getUserCards();
    return Scaffold(
      backgroundColor: bckcolor,
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.amber,
        title: Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Messages',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: display
          ? ListView(
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                                  "Sent",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, msg_list_br.id);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                                  "Received",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Container(
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(card_list.length, (index) {
                        return GestureDetector(
                          onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('$index'),
//                        emailBr: emailBr(seconds: 2),
//                      ));
//                      Navigator.pushNamed(context, Card_Details_T.id,
//                          arguments: {
//                            'status': card_list[index].status,
//                            'emailBr': card_list[index].emailBr,
//                            'msg': card_list[index].msg,
//                            'description': card_list[index].description,
//                            'subject': card_list[index].subject
//                          });
                          },
                          child: CardItem(
                            choice: card_list[index],
                            item: card_list[index],
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            )
          : Container(
              child: Center(
                  child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ))),
    );
  }

  void getUserCards() async {
//    Future.delayed(emailBr.zero, () {
//      pr.show();
//    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Text');

    List val = await usersCollection
        .find(dart_mongo.where.eq("emailBr", email))
        .toList();
    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String emailBr = val[i]['emailBr'];
      String status = val[i]['status'];
      String msg = val[i]['msg'];
      String Tname = val[i]['Tname'];
      String Reply = val[i]['Reply'];
      if (status == null) {
        status = '20-12-02';
      }
      if (Tname == null) {
        Tname = 'Tname';
      }
      if (Reply == null) {
        Reply = 'how';
      }

      Choice choices = Choice(
          emailBr: emailBr,
          status: status,
          msg: msg,
          Tname: Tname,
          Reply: Reply);
      if (status == 'SBT') list.add(choices);
    }
    setState(() {
      card_list = list;
      display = true;
    });
    await db.close();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
  }
}

class Choice {
  final String emailBr;
  final String status;
  final String msg;
  final String Tname;
  final String Reply;

  const Choice({
    this.emailBr,
    this.status,
    this.msg,
    this.Tname,
    this.Reply,
  });
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      this.choice,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          choice.Tname,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.msg,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.Reply != 'how' ? 'Reply: ' + choice.Reply : '',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                ),
//                Stack(
//                  children: <Widget>[
//                    Container(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              choice.msg,
//                              style: TextStyle(
//                                  color: Colors.grey,
//                                  fontFamily: 'SourceSansPro',
//                                  fontSize: 15.0,
//                                  fontStyle: FontStyle.italic),
//                            ),
//                          ),
//                        ],
//                      ),
//                      alignment: Alignment.topLeft,
//                    ),
//                    Container(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(right: 4.0),
//                            child: Text(
//                              '\$ ' + choice.Bname,
//                              style: TextStyle(
//                                color: Colors.black87,
//                                fontFamily: 'SourceSansPro',
//                                fontSize: 15.0,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      alignment: Alignment.topRight,
//                    ),
//                  ],
//                ),
              ],
            ),
          )),
    );
  }
}

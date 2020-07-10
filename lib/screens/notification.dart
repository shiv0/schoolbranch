import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification extends StatefulWidget {
  static String id = 'notification';
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  List notification_head;
  bool display = false;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    getUserCards();
    return Scaffold(
      backgroundColor: bckcolor,
      body: ListView(
          shrinkWrap: true,
          children: List.generate(notification_head.length, (index) {
            return GestureDetector(
              onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('$index'),
//                        duration: Duration(seconds: 2),
////                      ));
//                Navigator.pushNamed(context, Card_Details_T.id,
//                    arguments: {
//                      'date': card_list[index].date,
//                      'duration': card_list[index].duration,
//                      'amount': card_list[index].amount,
//                      'description': card_list[index].description,
//                      'subject': card_list[index].subject
//                    });
              },
              child: CardItem(
                choice: notification_head[index],
                item: notification_head[index],
              ),
            );
          })),
    );
  }

  void getUserCards() async {
//    Future.delayed(Duration.zero, () {
//      pr.show();
//    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Notifications');
    List val = await usersCollection
        .find(dart_mongo.where.eq("email", email))
        .toList();
    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String emailfrom = val[i]['emailfrom'];
      String notification = val[i]['notification'].toString();
      String ismessage = val[i]['ismessage'];
      Choice choices = Choice(
        emailfrom: emailfrom,
        notification: notification,
        ismessage: ismessage,
      );
      list.add(choices);
    }
    setState(() {
      notification_head = list;
      display = true;
    });
    await db.close();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
  }
}

class Choice {
  final String emailfrom;
  final String notification;
  final String ismessage;

  const Choice({
    this.emailfrom,
    this.notification,
    this.ismessage,
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
                      Icon(
                        Icons.alarm,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          choice.notification,
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
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeBhTeachers extends StatefulWidget {
  @override
  _HomeBhTeachersState createState() => _HomeBhTeachersState();
}

class _HomeBhTeachersState extends State<HomeBhTeachers> {
  List<Choice> card_list = [];
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    getUserCards();
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(card_list.length, (index) {
                  return CardItem(
                    choice: card_list[index],
                    item: card_list[index],
                  );
                })),
          )
        ],
      ),
    );
  }

  void getUserCards() async {
//    pr.show();
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    List val = await usersCollection.find().toList();
    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String duration = val[i]['duration'];
      String date = val[i]['date'].toString();
      String amount = val[i]['amount'];
      String name = val[i]['name'];
      String lname = val[i]['lname'];
      if (name == null) {
        name = 'check';
      }
      if (date == null) {
        date = '20-12-02';
      }
      Choice choices =
          Choice(duration: duration, date: date, amount: amount, name: name);
      list.add(choices);
    }
    setState(() {
      card_list = list;
    });
    await db.close();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
  }
}

class Choice {
  final String duration;
  final String date;
  final String amount;
  final String name;

  const Choice({this.duration, this.date, this.amount, this.name});
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
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.black87,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          choice.name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 20.0,
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
                      Icon(
                        Icons.alarm,
                        color: Colors.black87,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.duration,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.insert_invitation,
                        color: Colors.black87,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.date,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '\$',
                        style: TextStyle(color: Colors.black87),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          choice.amount,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          )),
    );
  }
}

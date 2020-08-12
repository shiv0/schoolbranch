import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sk_school/screens/card_details_T_bh.dart';

class HomeBhTeachers extends StatefulWidget {
  @override
  _HomeBhTeachersState createState() => _HomeBhTeachersState();
}

class _HomeBhTeachersState extends State<HomeBhTeachers> {
  List<Choice> card_list = [];
  ProgressDialog pr;
  bool display = false;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Please Wait..');
    getUserCards();
    return Scaffold(
      backgroundColor: bckcolor,
      body: display
          ? ListView(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(card_list.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Card_Details_T_BH.id,
                                arguments: {
                                  'email': card_list[index].email,
                                  'subject': card_list[index].subject,
                                  'duration': card_list[index].duration,
                                  'date': card_list[index].date,
                                  'amount': card_list[index].amount,
                                  'description': card_list[index].description,
                                  'status': card_list[index].status,
                                  'state': card_list[index].state,
                                });
                          },
                          child: CardItem(
                            choice: card_list[index],
                            item: card_list[index],
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 35.0,
                ),
              ],
            )
          : Container(
              child: Center(
                  child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
            ))),
    );
  }

  void getUserCards() async {
//    pr.show();
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
//    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('Cards');
    List val = await usersCollection.find().toList();
//    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String duration = val[i]['duration'];
      String date = val[i]['date'].toString();
      String amount = val[i]['amount'];
      String subject = val[i]['subject'];
      String description = val[i]['description'];
      String posted_date = val[i]['posted_date'];
      String name = val[i]['name'];
      String lname = val[i]['lname'];
      String email = val[i]['email'];
      String status = val[i]['status'];
      String state = val[i]['state'];
      if (name == null) {
        name = 'check';
      }
      if (status == null) {
        status = '-';
      }
      if (state == null) {
        state = '-';
      }
      if (date == null) {
        date = '20-12-02';
      }
      if (posted_date == null) {
        posted_date = '20-12-02';
      }
      Choice choices = Choice(
          duration: duration,
          date: date,
          amount: amount,
          name: name,
          email: email,
          subject: subject,
          status: status,
          state: state,
          posted_date: posted_date,
          description: description);
      list.add(choices);
    }
    setState(() {
      card_list = list;
      display = true;
    });
    await db.close();
    pr.hide().then((isHidden) {
//      print(isHidden);
    });
  }
}

class Choice {
  final String duration;
  final String date;
  final String amount;
  final String name;
  final String subject;
  final String description;
  final String status;
  final String email;
  final String state;
  final String posted_date;

  const Choice(
      {this.duration,
      this.date,
      this.state,
      this.amount,
      this.name,
      this.email,
      this.status,
      this.posted_date,
      this.subject,
      this.description});
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
                        Icons.perm_identity,
                        color: Colors.green,
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
                        Icons.location_city,
                        color: Colors.brown,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.state,
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
                        Icons.description,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.subject,
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
                        Icons.update,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.status,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          '\$' + choice.amount,
                          style: TextStyle(color: Colors.brown, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topRight,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          choice.posted_date,
                          style: TextStyle(color: Colors.brown, fontSize: 15.0),
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

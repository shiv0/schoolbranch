import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;

class HomeTBh extends StatefulWidget {
  @override
  _HomeBhState createState() => _HomeBhState();
}

class _HomeBhState extends State<HomeTBh> {
  List<Choice> card_list = [];
  List<Choice> _searchResult = [];
  String email, password, subject, re;
  TextEditingController controller = new TextEditingController();

  ProgressDialog pr;
  bool display = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckcolor,
      body: display
          ? ListView(
              children: <Widget>[
                Container(
                  color: bckcolor,
                  child: new Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 10, left: 10),
                    child: new Card(
                      color: Colors.white,
                      child: new ListTile(
                        leading: new Icon(
                          Icons.search,
                          color: Colors.black45,
                        ),
                        title: new TextField(
                          controller: controller,
                          style: TextStyle(color: Colors.black87),
                          decoration: new InputDecoration(
                              hintText: 'Search Subject ,Date..',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          onChanged: onSearchTextChanged,
                        ),
                        trailing: new IconButton(
                          icon: new Icon(
                            Icons.cancel,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: () {
                            controller.clear();
                            onSearchTextChanged('');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: _searchResult.length != 0 || controller.text.isNotEmpty
                      ? ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children:
                              List.generate(_searchResult.length, (index) {
                            return GestureDetector(
                              onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('$index'),
//                        duration: Duration(seconds: 2),
//                      ));
//                      Navigator.pushNamed(context, Cards_Details_BH.id,
//                          arguments: {
//                            'start_date': card_list[index].start_date,
//                            'end_date': card_list[index].end_date,
//                            'gender': card_list[index].gender,
//                            'duration': card_list[index].duration,
//                            'amount': card_list[index].amount,
//                            'description': card_list[index].description,
//                            'subject': card_list[index].subject
//                          });
                              },
                              child: CardItem(
                                choice: _searchResult[index],
                                item: _searchResult[index],
                              ),
                            );
                          }))
                      : ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(card_list.length, (index) {
                            return GestureDetector(
                              onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('$index'),
//                        duration: Duration(seconds: 2),
//                      ));
//                      Navigator.pushNamed(context, Cards_Details_BH.id,
//                          arguments: {
//                            'start_date': card_list[index].start_date,
//                            'end_date': card_list[index].end_date,
//                            'gender': card_list[index].gender,
//                            'duration': card_list[index].duration,
//                            'amount': card_list[index].amount,
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
                )
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('BHCards');
    List val = await usersCollection.find().toList();
    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String duration = val[i]['duration'];
      String gender = val[i]['gender'];
      String end_date = val[i]['end_date'].toString();
      String start_date = val[i]['start_date'].toString();
      String posted_date = val[i]['posted_date'].toString();
      String amount = val[i]['amount'].toString();
      String description = val[i]['description'];
      String subject = val[i]['subject'];
      if (start_date == null) {
        start_date = '20-12-02';
      }
      if (posted_date == null) {
        posted_date = '-';
      }
      Choice choices = Choice(
          duration: duration,
          start_date: start_date,
          end_date: end_date,
          posted_date: posted_date,
          gender: gender,
          amount: amount,
          description: description,
          subject: subject);
      list.add(choices);
    }
    setState(() {
      card_list = list;
      display = true;
    });
    await db.close();
//    pr.hide().then((isHidden) {
//      print(isHidden);
//    });
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    card_list.forEach((userDetail) {
      if ((userDetail.subject.toLowerCase()).contains(text.toLowerCase()) ||
          (userDetail.start_date.toLowerCase()).contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      } else
        print(userDetail.subject);
    });

    setState(() {});
  }
}

class Choice {
  final String duration;
  final String start_date;
  final String end_date;
  final String posted_date;
  final String amount;
  final String description;
  final String subject;
  final String gender;

  const Choice(
      {this.duration,
      this.start_date,
      this.end_date,
      this.posted_date,
      this.amount,
      this.description,
      this.subject,
      this.gender});
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
                        Icons.description,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          choice.subject,
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
                      Icon(
                        Icons.insert_invitation,
                        color: Colors.green,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
                        child: Text(
                          choice.start_date,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'SourceSansPro',
                              fontSize: 16.0),
                        ),
                      ),
                      Text(
                        ' - ',
                        style: TextStyle(color: Colors.black87),
                      ),
                      Text(
                        choice.end_date,
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'SourceSansPro',
                            fontSize: 15.0),
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
                        Icons.attach_money,
                        color: Colors.deepOrangeAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                  alignment: Alignment.topLeft,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.perm_identity,
                        color: Colors.brown,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          choice.gender,
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
                          choice.posted_date,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic),
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

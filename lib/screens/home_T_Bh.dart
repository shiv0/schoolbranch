import 'package:flutter/material.dart';
import 'package:sk_school/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;
import 'package:sk_school/screens/card_details_bh_T.dart';

class HomeTBh extends StatefulWidget {
  @override
  _HomeBhState createState() => _HomeBhState();
}

class _HomeBhState extends State<HomeTBh> {
  List<Choice> card_list = [];
  List<Choice> _searchResult = [];
  String email, password, subject, re, select_sub, select_amt, select_district;
  TextEditingController controller = new TextEditingController();

  ProgressDialog pr;
  bool display = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCards();
  }

  List<String> subject_list = ['Physics.', 'Chemistry.'],
      amount_list = ['16', '25'],
      district_list = ['district11', 'district22'];
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Text(
                      'Filter By',
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.black45,
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text("Subject",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  )),
                            ),
                            items: subject_list.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: new Text(
                                    value,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                select_sub = value;
                              });
                              getFilterUserCards();
                            },
                            value: select_sub,
                            elevation: 2,
                            focusColor: Colors.black45,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            isDense: true,
                            iconSize: 40.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.black45,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text("Amount",
                                    style: TextStyle(
                                      color: Colors.black87,
                                    )),
                              ),
                              items: amount_list.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: new Text(value),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  select_amt = value;
                                });
                                getFilterUserCards();
                              },
                              value: select_amt,
                              elevation: 2,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                              isDense: true,
                              iconSize: 40.0,
                            )),
                      ),
//                      Container(
//                        padding: EdgeInsets.symmetric(horizontal: 5),
//                        child: Theme(
//                            data: Theme.of(context).copyWith(
//                              canvasColor: Colors.white,
//                            ),
//                            child: DropdownButton<String>(
//                              iconEnabledColor: Colors.black45,
//                              hint: Padding(
//                                padding: const EdgeInsets.only(left: 15.0),
//                                child: Text("All",
//                                    style: TextStyle(
//                                      color: Colors.black87,
//                                    )),
//                              ),
//                              items: district_list.map((String value) {
//                                return new DropdownMenuItem<String>(
//                                  value: value,
//                                  child: Padding(
//                                    padding: const EdgeInsets.only(left: 15.0),
//                                    child: new Text(value),
//                                  ),
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//                                setState(() {
//                                  select_district = value;
//                                });
//                                onSearchFilterChanged('');
//                              },
//                              value: select_district,
//                              elevation: 2,
//                              style: TextStyle(
//                                  color: Colors.black87, fontSize: 15),
//                              isDense: true,
//                              iconSize: 40.0,
//                            )),
//                      ),
                    ],
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Card_Details_BH_T.id,
                                      arguments: {
                                        'email': card_list[index].email,
                                        'subject': card_list[index].subject,
                                        'duration': card_list[index].duration,
                                        'amount': card_list[index].amount,
                                        'date': card_list[index].start_date +
                                            ' - ' +
                                            card_list[index].end_date,
                                        'description':
                                            card_list[index].description,
                                        'status': card_list[index].status,
                                        'start_date':
                                            card_list[index].start_date,
                                        'end_date': card_list[index].end_date,
                                        'posted_date':
                                            card_list[index].posted_date,
                                        'state': card_list[index].state,
                                        'gender': card_list[index].gender,
                                      });
                                },
                                child: CardItem(
                                  choice: card_list[index],
                                  item: card_list[index],
                                ),
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
      String district = val[i]['district'];
      String name = val[i]['name'];
      String status = val[i]['status'];
      String state = val[i]['state'];
      String email = val[i]['email'];
      if (name == null) {
        name = 'check';
      }
      if (status == null) {
        status = '-';
      }
      if (state == null) {
        state = '-';
      }
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
          district: district,
          status: status,
          name: name,
          state: state,
          email: email,
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

  void getFilterUserCards() async {
    String sub, amt, dist;
    if (select_sub == null) {
      sub = '';
    } else
      sub = select_sub;
    if (select_amt == null) {
      amt = '';
    } else
      amt = select_amt;
//    if (select_district == null) {
//      dist = '';
//    } else
//      dist = select_district;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    dart_mongo.Db db = dart_mongo.Db(URL);
    await db.open();
    print('database connected');
    dart_mongo.DbCollection usersCollection = db.collection('BHCards');
    List val = await usersCollection
        .find(dart_mongo.where.match("subject", sub).match("amount", amt))
        .toList();
    print('huh$val');
    List<Choice> list = [];
    for (int i = val.length - 1; i >= 0; i--) {
      String duration = val[i]['duration'];
      String gender = val[i]['gender'];
      String email = val[i]['email'];
      String end_date = val[i]['end_date'].toString();
      String start_date = val[i]['start_date'].toString();
      String posted_date = val[i]['posted_date'].toString();
      String amount = val[i]['amount'].toString();
      String description = val[i]['description'];
      String subject = val[i]['subject'];
      String district = val[i]['district'];
      String name = val[i]['name'];
      if (name == null) {
        name = '-';
      }
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
          district: district,
          name: name,
          email: email,
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

  onSearchFilterChanged(String text) async {
    _searchResult.clear();
    if (select_sub == null && select_amt == null && select_district == null) {
      setState(() {});
      return;
    }
    card_list.forEach((userDetail) {
      if ((userDetail.subject.toLowerCase())
              .contains(select_sub.toLowerCase()) ||
          (userDetail.amount.toLowerCase())
              .contains(select_amt.toLowerCase()) ||
          (userDetail.district.toLowerCase())
              .contains(select_district.toLowerCase())) {
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
  final String email;
  final String status;
  final String district;
  final String state;
  final String name;

  const Choice(
      {this.duration,
      this.start_date,
      this.name,
      this.end_date,
      this.posted_date,
      this.amount,
      this.description,
      this.subject,
      this.status,
      this.email,
      this.district,
      this.state,
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
                        Icons.supervised_user_circle,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          choice.name == null ? '-' : choice.name,
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
                        Icons.description,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
                        child: Text(
                          choice.subject,
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
                      Icon(
                        Icons.attach_money,
                        color: Colors.deepOrangeAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          choice.amount,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic),
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

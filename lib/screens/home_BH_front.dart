import 'package:flutter/material.dart';
import 'package:sk_school/screens/add_form.dart';

class HomeBhFront extends StatefulWidget {
  @override
  _HomeBhFrontState createState() => _HomeBhFrontState();
}

class _HomeBhFrontState extends State<HomeBhFront> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AddForm.id);
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
//          Container(
//            child: ListView(
//                shrinkWrap: true,
//                physics: const NeverScrollableScrollPhysics(),
//                children: List.generate(card_list.length, (index) {
//                  return CardItem(
//                    choice: card_list[index],
//                    item: card_list[index],
//                  );
//                })),
//          )
        ],
      ),
    );
  }
}

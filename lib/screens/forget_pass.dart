import 'package:flutter/material.dart';

class Forget_pass extends StatefulWidget {
  static String id = 'forget_pass';
  @override
  _Forget_passState createState() => _Forget_passState();
}

class _Forget_passState extends State<Forget_pass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to Flutter",
        home: new Material(
            child: new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/ff.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.all(30.0),
                child: new Container(
                  child: new Center(
                      child: new Column(children: [
                    new Padding(padding: EdgeInsets.only(top: 14.0)),
                    new Text(
                      'Sk School',
                      style: new TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 45.0)),
                    TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your mobile',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            //Implement login functionality.
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Forget',
                          ),
                        ),
                      ),
                    ),
                  ])),
                ))));
  }
}

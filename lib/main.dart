import 'package:flutter/material.dart';
import 'package:sk_school/screens/add_form.dart';
import 'package:sk_school/screens/forget_pass.dart';
import 'package:sk_school/screens/home_T_screen.dart';
import 'package:sk_school/screens/home_screen_bh.dart';
import 'package:sk_school/screens/sign_up.dart';
import 'package:sk_school/screens/welcome_screen.dart';
import 'package:sk_school/screens/login_screen.dart';
import 'package:sk_school/screens/registration_screen.dart';
import 'package:sk_school/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Sign_up.id: (context) => Sign_up(),
        Forget_pass.id: (context) => Forget_pass(),
        Home_screen.id: (context) => Home_screen(),
        HomeScreenBh.id: (context) => HomeScreenBh(),
        AddForm.id: (context) => AddForm(),
      },
    );
  }
}

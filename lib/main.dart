import 'package:flutter/material.dart';
import 'package:sk_school/screens/Edit_card_BH.dart';
import 'package:sk_school/screens/Edit_card_T.dart';
import 'package:sk_school/screens/add_form.dart';
import 'package:sk_school/screens/add_form_BH.dart';
import 'package:sk_school/screens/card_details_BH.dart';
import 'package:sk_school/screens/card_details_T.dart';
import 'package:sk_school/screens/card_details_T_bh.dart';
import 'package:sk_school/screens/forget_pass.dart';
import 'package:sk_school/screens/Edit_BH_profile.dart';
import 'package:sk_school/screens/home_BH_profile.dart';
import 'package:sk_school/screens/home_T_screen.dart';
import 'package:sk_school/screens/home_screen_bh.dart';
import 'package:sk_school/screens/registration_otp.dart';
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
        Card_Details_T.id: (context) => Card_Details_T(),
        Edit_Card_T.id: (context) => Edit_Card_T(),
        Card_Details_T_BH.id: (context) => Card_Details_T_BH(),
        Registration_Otp.id: (context) => Registration_Otp(),
        Add_Form_BH.id: (context) => Add_Form_BH(),
        Cards_Details_BH.id: (context) => Cards_Details_BH(),
        Edit_Card_BH.id: (context) => Edit_Card_BH(),
        Edit_BH_Profile.id: (context) => Edit_BH_Profile(),
        Home_BH_Profile.id: (context) => Home_BH_Profile(),
      },
    );
  }
}

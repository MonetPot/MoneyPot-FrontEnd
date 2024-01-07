import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:flutter/material.dart";
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/const/styles.dart';
import 'package:money_pot/screens/login/social_login.dart';
import 'package:money_pot/screens/navigation.dart';
import '../../../toast.dart';
import 'package:money_pot/screens/login/auth_login_page.dart';

import '../../Screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _signIn() async {

    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password, context);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
            (Route<dynamic> route) => false,
      );
    } else {
      showToast(message: "some error occurred");
    }

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 64.0),
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                'assets/icons/login.svg',
                width: 100.0,
                height: 100.0,
              ),
            ),
            headlinesWidget(),
            emailTextFieldWidget(),
            passwordTextFieldWidget(),
            loginButtonWidget(),
            SocialLogin(),
            signupWidget(context)
          ],
        ),
      ),
    );
  }

  Widget emailTextFieldWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 32.0, top: 32.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 16.0)),
          ],
          borderRadius: new BorderRadius.circular(12.0),
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.4),
              end: FractionalOffset(0.9, 0.7),
              stops: [
                0.2,
                0.9
              ],
              colors: [
                Color(0xffFFC3A0),
                Color(0xffFFAFBD),
              ])),
      child: TextField(
        controller: _emailController,
        style: hintAndValueStyle,
        onSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        decoration: new InputDecoration(
            suffixIcon: Icon(Icons.email_rounded),
            contentPadding: new EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: 'Email',
            hintStyle: hintAndValueStyle),
      ),
    );
  }

  Widget passwordTextFieldWidget() {
    return Container(
      margin: EdgeInsets.only(left: 32.0, right: 16.0),
      child: TextField(
        focusNode: _passwordFocusNode,
        controller: _passwordController,
        style: hintAndValueStyle,
        obscureText: true,
        decoration: new InputDecoration(
            suffixIcon: Icon(Icons.password_rounded),
            fillColor: Color(0x3305756D),
            filled: true,
            contentPadding: new EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: 'Password',
            hintStyle: hintAndValueStyle),
      ),
    );
  }
   Widget loginButtonWidget() {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
       padding: EdgeInsets.symmetric(horizontal: 36.0),
       decoration: BoxDecoration(
         borderRadius: new BorderRadius.circular(36.0),
         gradient: LinearGradient(
           begin: FractionalOffset.centerLeft,
           stops: [0.2, 1],
           colors: [
             Color(0xff000000),
             Color(0xff434343),
           ],
         ),
         boxShadow: [
           BoxShadow(
             color: Colors.black12,
             blurRadius: 15,
             spreadRadius: 0,
             offset: Offset(0.0, 32.0),
           ),
         ],
       ),
       child: ElevatedButton(
         onPressed: _isSigningIn ? null : _signIn,
         style: ElevatedButton.styleFrom(
           primary: Colors.transparent,
           shadowColor: Colors.transparent,
           padding: EdgeInsets.symmetric(vertical: 16.0),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(36.0),
           ),
           onPrimary: Color(0xffF1EA94),
         ),
         child: Text(
           'LOGIN',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontFamily: 'Montserrat',
           ),
         ),
       ),
     );
   }

}

Widget signupWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 48.0, top: 5.0),
    child: Row(
      children: <Widget>[
        Text(
          'Don\'t have an account?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: Color(0xff353535),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
        )
      ],
    ),
  );
}

Widget headlinesWidget() {
  return Container(
    margin: EdgeInsets.only(left: 48.0, top: 32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'WELCOME BACK!',
          textAlign: TextAlign.left,
          style: TextStyle(
              letterSpacing: 3,
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 48.0),
          child: Text(
            'Log in \nto continue.',
            textAlign: TextAlign.left,
            style: TextStyle(
              letterSpacing: 3,
              fontSize: 32.0,
              fontFamily: 'Montserrat',
            ),
          ),
        )
      ],
    ),
  );
}
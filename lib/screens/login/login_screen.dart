// import 'package:flutter/material.dart';
// import 'package:money_pot/responsive.dart';
//
// import '../../components/background.dart';
// import 'components/login_form.dart';
// import 'components/login_screen_image.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: SingleChildScrollView(
//         child: Responsive(
//           mobile: const MobileLoginScreen(),
//           desktop: Row(
//             children: [
//               const Expanded(
//                 child: LoginScreenTopImage(),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       width: 450,
//                       child: LoginForm(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MobileLoginScreen extends StatelessWidget {
//   const MobileLoginScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const LoginScreenTopImage(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: LoginForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],
//     );
//   }
// }

///
/// Created by NieBin on 2018/12/25
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:flutter/material.dart";
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/const/styles.dart';
import '../../../toast.dart';
import 'package:money_pot/screens/login/auth_page.dart';
import 'package:money_pot/screens/groups/group_screen.dart';

import '../../Screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigning = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {

    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => GroupsScreen()),

      );
    } else {
      showToast(message: "some error occurred");
    }
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
            // Center(
            //   child: Image.asset(
            //     'assets/icons/login.svg',
            //     width: 100.0,
            //     height: 100.0,
            //     fit: BoxFit.cover,
            //   ),
            // ),
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
              // Add one stop for each color. Stops should increase from 0 to 1
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
        decoration: new InputDecoration(
            suffixIcon: Icon(IconData(0xe902, fontFamily: 'Icons'),
                color: Color(0xff35AA90), size: 10.0),
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
        controller: _passwordController,
        style: hintAndValueStyle,
        obscureText: true,
        decoration: new InputDecoration(
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
      margin: EdgeInsets.only(left: 32.0, top: 32.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: _isSigningIn ? null : _signIn,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: Offset(0.0, 32.0)),
                  ],
                  borderRadius: new BorderRadius.circular(36.0),
                  gradient: LinearGradient(begin: FractionalOffset.centerLeft,
// Add one stop for each color. Stops should increase from 0 to 1
                      stops: [
                        0.2,
                        1
                      ], colors: [
                        Color(0xff000000),
                        Color(0xff434343),
                      ])),
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Color(0xffF1EA94),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget signupWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 48.0, top: 32.0),
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
            // print('Sign Up button pressed');
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

// import "package:flutter/material.dart";
//
// import '../../const/gradient.dart';
// import '../widgets/date_picker.dart';
// // import 'widgets/gender_picker.dart';
// // import 'widgets/location_picker.dart';
// import '../widgets/signup_appbar.dart';
// import '../widgets/signup_profile_image_picker.dart';
// import '../widgets/signup_button.dart';
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SignupAppbar(
//         title: 'CREATE ACCOUNT',
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: 64.0),
//         decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           children: <Widget>[
//             // Center(
//             //   child: ProfileImagePicker(
//             //     margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
//             //   ),
//             // ),
//             DatePicker(),
//             // GenderPicker(),
//             // LocationPicker(),
//             Container(
//                 margin: EdgeInsets.only(top: 32.0),
//                 child: Center(child: signupButton('NEXT')))
//           ],
//         ),
//       ),
//     );
//   }
// }